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
    for path in sorted(root.rglob("*")):
        rel = path.relative_to(root)
        if path.is_symlink():
            raise ValueError(f"symlinks are not supported: {rel}")
        if path.is_file():
            items.append((rel, path.read_bytes()))
        elif not path.is_dir():
            raise ValueError(f"unsupported entry: {rel}")
    return items


def make_image(source: Path, output: Path, megabytes: int, bootcd: Path | None = None) -> None:
    files = collect(source)
    dirs = set()
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

    # Layout: RedSea header, bitmap, root directory, then file data.
    volume_blocks = megabytes * 1024 * 1024 // BLOCK
    bitmap_blocks = max(1, (volume_blocks + BLOCK * 8 - 1) // (BLOCK * 8))
    data_start = 1 + bitmap_blocks
    dir_cluster[Path(".")] = data_start
    next_cluster = data_start + root_blocks
    dir_blocks = {directory: blocks((2 + children(directory)) * ENTRY) for directory in dir_names}
    for directory in dir_names:
        dir_cluster[directory] = next_cluster
        next_cluster += dir_blocks[directory]

    file_clusters = {}
    for path, data in files:
        file_clusters[path] = next_cluster
        next_cluster += blocks(len(data))
    if next_cluster > volume_blocks:
        raise ValueError("source tree does not fit in requested image size")

    header = bytearray(BLOCK)
    header[3] = REDSEA_SIGNATURE
    struct.pack_into("<qqqqq", header, 8, 0, volume_blocks, data_start, bitmap_blocks, 1)
    struct.pack_into("<H", header, 510, 0xAA55)

    bitmap = bytearray(bitmap_blocks * BLOCK)
    def reserve(start: int, count: int) -> None:
        for cluster in range(start, start + count):
            bitmap[cluster // 8] |= 1 << (cluster % 8)
    reserve(0, data_start)
    reserve(data_start, root_blocks)
    reserve(dir_cluster[Path(".")], root_blocks)
    for directory, cluster in dir_cluster.items():
        if directory != Path("."):
            reserve(cluster, dir_blocks[directory])
    for path, data in files:
        reserve(file_clusters[path], blocks(len(data)))

    def directory_data(directory: Path) -> bytes:
        entries = []
        cluster = dir_cluster[directory]
        entries.append(entry(".", ATTR_DIR | ATTR_CONTIGUOUS, cluster, BLOCK))
        parent = directory.parent if directory != Path(".") else directory
        entries.append(entry("..", ATTR_DIR | ATTR_CONTIGUOUS, dir_cluster[parent], BLOCK))
        for child in sorted(d for d in dir_names if d.parent == directory):
            entries.append(entry(child.name, ATTR_DIR | ATTR_CONTIGUOUS, dir_cluster[child], BLOCK))
        for path, data in files:
            if path.parent == directory:
                entries.append(entry(path.name, ATTR_CONTIGUOUS, file_clusters[path], len(data)))
        size = root_blocks if directory == Path(".") else dir_blocks[directory]
        return b"".join(entries).ljust(size * BLOCK, b"\0")

    output.parent.mkdir(parents=True, exist_ok=True)
    prefix = 24 * 2048
    with output.open("wb") as stream:
        stream.truncate(prefix + volume_blocks * BLOCK)
        if bootcd:
            stage1 = bootcd.read_bytes()[:2048].ljust(2048, b"\0")
            stream.seek(21 * 2048)
            stream.write(stage1)
            catalog = bytearray(2048)
            catalog[0] = 1
            catalog[1:9] = b"TempleOS"
            catalog[30:32] = struct.pack("<H", 0xAA55)
            catalog[32] = 0x88
            catalog[33] = 0
            catalog[34:36] = struct.pack("<H", 4)
            catalog[40:44] = struct.pack("<I", 21)
            stream.seek(20 * 2048)
            stream.write(catalog)
            pvd = bytearray(2048)
            pvd[0:7] = b"\x01CD001\x01"
            pvd[40:48] = b"TEMPLEOS"
            pvd[80:88] = struct.pack("<I", (prefix + volume_blocks * BLOCK) // 2048)
            pvd[128:132] = struct.pack("<H", 2048)
            stream.seek(16 * 2048)
            stream.write(pvd)
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
            stream.seek(prefix + dir_cluster[directory] * BLOCK)
            stream.write(directory_data(directory))
        for path, data in files:
            stream.seek(prefix + file_clusters[path] * BLOCK)
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
