# Linux RedSea generator

`redsea.py` creates a raw RedSea volume from a directory tree:

```sh
python3 tools/linux/redsea.py build/templeos build/templeos-redsea.img
```

The image contains the RedSea header, allocation bitmap, contiguous directory
entries, and file contents. `make redsea-image` runs the same operation after
preparing the current source tree and adding the 2013 bootstrap kernel/compiler
pair under `0000boot/` and `compiler/`.

The generated hybrid ISO includes the V5.03 El Torito stage, an absolute-cluster
RedSea volume, and the matching compressed bootstrap tree. It has been verified
to load the kernel and compiler and reach the TempleOS desktop under QEMU.

`redsea_extract.py` is the provenance tool used to extract raw compressed files
from the matching historical ISO. It does not decompress or rewrite them.
