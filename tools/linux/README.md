# Linux RedSea generator

`redsea.py` creates a raw RedSea volume from a directory tree:

```sh
python3 tools/linux/redsea.py build/templeos build/templeos-redsea.img
```

The image contains the RedSea header, allocation bitmap, contiguous directory
entries, and file contents. `make redsea-image` runs the same operation after
preparing the current source tree.

This is a filesystem image generator, not yet a complete TempleOS boot-image
builder. TempleOS-specific boot code and the historical `0000kernel` handoff
still need to be placed at the exact CD/El Torito offsets before QEMU can boot
the result.
