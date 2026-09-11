# TempleOS bootstrap seed

This directory preserves the minimum bootstrapping artifacts recovered from
the first repository snapshot containing `0000Kernel.BIN.C`:

- Source commit: `17b71f1a2d7929728812049de05e5872e24d6d28`
- Snapshot date: 2013-03-15
- Original release: `TempleOSTS_130315.ISO`

The files are historical generated binaries, not part of the modern `src/`
tree. They are kept separately so they can be used as a bootstrap environment
while the current source is rebuilt and migrated.

The seed contains the kernel handoff, CD boot record, MHD2 boot code, and the
matching compiler binary. It is not currently wired into the Linux Makefile;
using it to produce a new RedSea ISO still requires running the corresponding
TempleOS boot/install tooling in a compatible TempleOS environment.
