#!/usr/bin/env python3
"""Build a minimal TempleOS RedSea image from a directory tree.

This writes the on-disk structures documented by TempleOS: 512-byte clusters,
64-byte directory entries, contiguous files, and a single allocation bitmap.
It is deliberately independent of ISO authoring tools so the result can be
inspected and tested on Linux.
"""

from __future__ import annotations

import argparse
import os
import struct
import sys
import time
from pathlib import Path

BLOCK = 512
ENTRY = 64
NAME_BYTES = 38
REDSEA_SIGNATURE = 0x88
ATTR_DIR = 0x10
ATTR_COMPRESSED = 0x400
ATTR_CONTIGUOUS = 0x800


def blocks(size: int) -> int:
    return max(1, (size + BLOCK - 1) // BLOCK)


def dos_date_time() -> tuple[int, int]:
    now = time.localtime()
    date = ((now.tm_year - 1980) << 9) | (now.tm_mon << 5) | now.tm_mday
    clock = (now.tm_hour << 11) | (now.tm_min << 5) | (now.tm_sec // 2)
    return clock, date


def entry(name: str, attr: int, cluster: int, size: int) -> bytes:
    raw = name.encode("ascii")
    if len(raw) >= NAME_BYTES:
        raise ValueError(f"RedSea name is too long: {name!r}")
    clock, date = dos_date_time()
    # CDirEntry: U16 attr; U8 name[38]; I64 clus; I64 size; CDate.
    return struct.pack("<H", attr) + raw + b"\0" * (NAME_BYTES - len(raw)) + struct.pack(
        "<qqII", cluster, size, clock, date
    )


def collect(root: Path):
    items = []
    directories = set()
    for path in sorted(root.rglob("*")):
        rel = path.relative_to(root)
        if path.is_symlink():
            raise ValueError(f"symlinks are not supported: {rel}")
        if path.is_file():
            items.append((rel, path.read_bytes()))
        elif path.is_dir():
            directories.add(rel)
        else:
            raise ValueError(f"unsupported entry: {rel}")
    return items, directories


def make_image(source: Path, output: Path, megabytes: int, bootcd: Path | None = None) -> None:
    files, dirs = collect(source)
    for path, _ in files:
        parent = path.parent
        while parent != Path("."):
            dirs.add(parent)
            parent = parent.parent
    # Every directory is contiguous. Root has three reserved entries.
    dir_names = sorted(dirs, key=lambda p: (len(p.parts), str(p)))
    dir_cluster = {Path("."): 0}
    total_entries = 3 + len(files) + len(dir_names)
    children = lambda directory: sum(1 for p, _ in files if p.parent == directory) + sum(
        1 for d in dirs if d.parent == directory
    )
    root_blocks = blocks((3 + children(Path("."))) * ENTRY)

    # TempleOS places RedSea immediately after the LBA 21 boot image, at
    # CD LBA 22 (88 512-byte blocks).
    volume_offset = 22 * 4 if bootcd else 0
    # Layout: RedSea header, bitmap, root directory, then file data.
    volume_blocks = megabytes * 1024 * 1024 // BLOCK
    bitmap_blocks = max(1, (volume_blocks + BLOCK * 8 - 1) // (BLOCK * 8))
    data_start = 1 + bitmap_blocks
    dir_cluster[Path(".")] = volume_offset + data_start
    next_cluster = volume_offset + data_start + root_blocks
    dir_blocks = {directory: blocks((2 + children(directory)) * ENTRY) for directory in dir_names}
    for directory in dir_names:
        dir_cluster[directory] = next_cluster
        next_cluster += dir_blocks[directory]

    file_clusters = {}
    for path, data in files:
        file_clusters[path] = next_cluster
        next_cluster += blocks(len(data))
    if next_cluster - volume_offset > volume_blocks:
        raise ValueError("source tree does not fit in requested image size")

    header = bytearray(BLOCK)
    header[3] = REDSEA_SIGNATURE
    struct.pack_into(
        "<qqqqq", header, 8, volume_offset, volume_blocks,
        dir_cluster[Path(".")], bitmap_blocks, 1
    )
    struct.pack_into("<H", header, 510, 0xAA55)

    bitmap = bytearray(bitmap_blocks * BLOCK)
    def reserve(start: int, count: int) -> None:
        for cluster in range(start, start + count):
            bit = cluster - (volume_offset + data_start)
            if bit >= 0:
                bitmap[bit // 8] |= 1 << (bit % 8)
    reserve(dir_cluster[Path(".")], root_blocks)
    for directory, cluster in dir_cluster.items():
        if directory != Path("."):
            reserve(cluster, dir_blocks[directory])
    for path, data in files:
        reserve(file_clusters[path], blocks(len(data)))

    def directory_data(directory: Path) -> bytes:
        entries = []
        cluster = dir_cluster[directory]
        size = root_blocks if directory == Path(".") else dir_blocks[directory]
        entries.append(entry(".", ATTR_DIR | ATTR_CONTIGUOUS, cluster, size * BLOCK))
        parent = directory.parent if directory != Path(".") else directory
        entries.append(entry("..", ATTR_DIR | ATTR_CONTIGUOUS, dir_cluster[parent], 0))
        for child in sorted(d for d in dir_names if d.parent == directory):
            entries.append(entry(child.name, ATTR_DIR | ATTR_CONTIGUOUS, dir_cluster[child], BLOCK))
        for path, data in files:
            if path.parent == directory:
                attr = ATTR_CONTIGUOUS
                if path.name.lower().endswith(".z"):
                    attr |= ATTR_COMPRESSED
                entries.append(entry(path.name, attr, file_clusters[path], len(data)))
        return b"".join(entries).ljust(size * BLOCK, b"\0")

    output.parent.mkdir(parents=True, exist_ok=True)
    prefix = volume_offset * BLOCK
    with output.open("wb") as stream:
        stream.truncate(prefix + volume_blocks * BLOCK)
        if bootcd:
            stage1 = bytearray(bootcd.read_bytes()[:2048].ljust(2048, b"\0"))
            stage2 = next(
                (path for path in file_clusters if str(path).lower() == "0000boot/0000kernel.bin.c"),
                None,
            )
            if stage2 is None:
                raise ValueError("missing required boot file: 0000Boot/0000Kernel.BIN.C")
            stage2_cluster = file_clusters[stage2]
            stage2_size = next(data for path, data in files if path == stage2)
            stage2_blocks = (len(stage2_size) + 2047) // 2048
            shift_blocks = stage2_cluster & 3
            if shift_blocks:
                stage2_blocks += 1
            struct.pack_into("<IHH", stage1, 0x88, stage2_cluster >> 2, stage2_blocks, shift_blocks)
            stream.seek(21 * 2048)
            stream.write(stage1)
            catalog = bytearray(2048)
            catalog[0] = 1
            catalog[1] = 0
            catalog[4:12] = b"TempleOS"
            catalog[30:32] = struct.pack("<H", 0xAA55)
            catalog[32] = 0x88
            catalog[33] = 0
            catalog[38:40] = struct.pack("<H", 4)
            catalog[40:44] = struct.pack("<I", 21)
            words = list(struct.unpack("<16H", catalog[:32]))
            words[14] = (-sum(words)) & 0xFFFF
            catalog[:32] = struct.pack("<16H", *words)
            stream.seek(20 * 2048)
            stream.write(catalog)
            pvd = bytearray(2048)
            pvd[0:7] = b"\x01CD001\x01"
            pvd[40:48] = b"TEMPLEOS"
            pvd[80:88] = struct.pack("<I", (prefix + volume_blocks * BLOCK) // 2048)
            pvd[128:132] = struct.pack("<H", 2048)
            root_cluster = dir_cluster[Path(".")]
            pvd[152:160] = struct.pack("<I", root_cluster) + struct.pack(">I", root_cluster)
            pvd[314:329] = b"TempleOS RedSea"
            pvd[877] = 1
            stream.seek(16 * 2048)
            stream.write(pvd)
            boot_record = bytearray(2048)
            boot_record[0:7] = b"\x00CD001\x01"
            boot_record[7:30] = b"EL TORITO SPECIFICATION"
            boot_record[0x47:0x4B] = struct.pack("<I", 20)
            stream.seek(17 * 2048)
            stream.write(boot_record)
            supplementary = bytearray(pvd)
            supplementary[0] = 2
            stream.seek(18 * 2048)
            stream.write(supplementary)
            term = bytearray(2048)
            term[0:7] = b"\xffCD001\x01"
            stream.seek(19 * 2048)
            stream.write(term)
        stream.seek(prefix)
        stream.write(header)
        stream.write(bitmap)
        stream.seek(prefix + data_start * BLOCK)
        stream.write(directory_data(Path(".")))
        for directory in dir_names:
            stream.seek(prefix + (dir_cluster[directory] - volume_offset) * BLOCK)
            stream.write(directory_data(directory))
        for path, data in files:
            stream.seek(prefix + (file_clusters[path] - volume_offset) * BLOCK)
            stream.write(data)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--size-mb", type=int, default=64)
    parser.add_argument("--bootcd", type=Path, help="historical 2048-byte TempleOS CD boot stage")
    args = parser.parse_args()
    try:
        make_image(args.source, args.output, args.size_mb, args.bootcd)
    except (OSError, ValueError) as error:
        print(f"redsea: error: {error}", file=sys.stderr)
        return 1
    print(f"wrote {args.output} ({args.size_mb} MiB)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
