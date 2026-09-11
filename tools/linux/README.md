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
to execute the boot stage and initialize the TempleOS kernel; the final desktop
startup still requires further runtime compatibility work.

`make redsea-image` also stages the HolyC Lua runtime, a TempleOS launcher, and
the project's minimal personal menu. The runtime source is kept uncompressed so
it can be compiled from inside TempleOS with its native `Compiler.BIN.Z`; the
menu intentionally contains only the Lua entry while bootstrap compatibility is
being established.

`redsea_extract.py` is the provenance tool used to extract raw compressed files
from the matching historical ISO. It does not decompress or rewrite them.
