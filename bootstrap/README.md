# TempleOS bootstrap seed

This directory preserves the minimum bootstrapping artifacts recovered from
the first repository snapshot containing `0000Kernel.BIN.C`:

- Source commit: `17b71f1a2d7929728812049de05e5872e24d6d28`
- Snapshot date: 2013-03-15
- Original release: `TempleOSTS_130315.ISO`

The files are historical generated binaries, not part of the modern `src/`
tree. They are kept separately so they can be used as a bootstrap environment
while the current source is rebuilt and migrated.

The seed contains the MBR, kernel handoff, CD boot record, MHD2 boot code, and
the matching compiler binary. These are all generated boot/compiler artifacts
available in the selected original repository snapshot. It is not currently wired into the Linux Makefile;
using it to produce a new RedSea ISO still requires running the corresponding
TempleOS boot/install tooling in a compatible TempleOS environment.

## TempleOS V5.03 pair

`templeos-v5.03/` preserves the matching pair from commit
`1dd8859b7803355f41d75222d01ed42d5dda057f`:

- `0000boot/0000kernel.bin.c`
- `compiler/compiler.bin`

That commit does not contain the CD boot record, MBR, or a complete disk
image, so this pair is not independently bootable either. It is kept separate
from the 2013 seed because the formats and source tree differ.
