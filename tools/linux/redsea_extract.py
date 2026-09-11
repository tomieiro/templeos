#!/usr/bin/env python3
"""Extract raw files from a TempleOS RedSea ISO without decompressing them."""

from __future__ import annotations

import argparse
import struct
from pathlib import Path

BLOCK = 512
ENTRY = 64
ATTR_DIR = 0x10


def records(image: bytes, cluster: int, size: int):
    data = image[cluster * BLOCK : cluster * BLOCK + size]
    for offset in range(0, len(data), ENTRY):
        raw = data[offset : offset + ENTRY]
        if len(raw) < ENTRY:
            break
        attr = struct.unpack_from("<H", raw)[0]
        name = raw[2:40].split(b"\0", 1)[0].decode("ascii", "strict")
        child_cluster, child_size = struct.unpack_from("<qq", raw, 40)
        if name:
            yield name, attr, child_cluster, child_size


def extract(image_path: Path, output: Path) -> None:
    image = image_path.read_bytes()
    supplementary = image[18 * 2048 : 19 * 2048]
    if supplementary[:7] != b"\x02CD001\x01":
        raise ValueError("TempleOS supplementary ISO descriptor not found")
    if supplementary[314:442].rstrip(b"\0 ") != b"TempleOS RedSea":
        raise ValueError("ISO is not a TempleOS RedSea image")
    root_cluster = struct.unpack_from("<I", supplementary, 152)[0]
    root_size = struct.unpack_from("<q", image, root_cluster * BLOCK + 48)[0]

    def walk(cluster: int, size: int, destination: Path) -> None:
        destination.mkdir(parents=True, exist_ok=True)
        for name, attr, child_cluster, child_size in records(image, cluster, size):
            if name in (".", "..") or (attr & ATTR_DIR and child_cluster == cluster):
                continue
            target = destination / name
            if attr & ATTR_DIR:
                walk(child_cluster, child_size, target)
            else:
                target.write_bytes(
                    image[child_cluster * BLOCK : child_cluster * BLOCK + child_size]
                )

    walk(root_cluster, root_size, output)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("image", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    extract(args.image, args.output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
