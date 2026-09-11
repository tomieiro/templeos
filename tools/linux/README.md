# Linux RedSea generator

`redsea.py` creates a raw RedSea volume from a directory tree:

```sh
python3 tools/linux/redsea.py build/templeos build/templeos-redsea.img
```

The image contains the RedSea header, allocation bitmap, contiguous directory
entries, and file contents. `make redsea-image` runs the same operation after
preparing the current source tree and adding the 2013 bootstrap kernel/compiler
pair under `0000boot/` and `compiler/`.

This is a filesystem image generator, not yet a complete TempleOS boot-image
builder. The historical CD boot stage and handoff are now placed at the
documented offsets, but the current source still does not provide a matching
`Kernel.BIN.C`; QEMU boot success therefore remains unverified.
