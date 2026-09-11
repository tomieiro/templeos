                           TempleOS

Repository layout
-----------------
The TempleOS source tree is under src/. Documentation is under docs/ and the
Linux-only TOSZ utility source is under tools/linux/. Run "make" on Linux to
build that utility as build/TOSZ. The HolyC kernel and compiler still must be
compiled from inside TempleOS, as described below.

Build and QEMU testing
----------------------
Run `make` to compile the Linux utility, validate the Lua launcher and validate
the HolyC Lua entry point with `hcc`. Run `make prepare` to create a
TempleOS-shaped tree under `build/templeos/`. The tree can be copied into a
TempleOS disk or ISO from inside TempleOS.

Run `make source-iso` to package that tree as `build/templeos-source.iso`.
When `make qemu TEMPLEOS_IMAGE=/path/to/templeos.img` is used, this source ISO
is attached as a second CD-ROM so it can be mounted and copied from inside the
TempleOS VM.

To boot an existing TempleOS disk image:

    make qemu TEMPLEOS_IMAGE=/path/to/templeos.img

To boot an existing ISO without rebuilding it:

    make qemu-iso

The first execution downloads the official base ISO to
`build/TOS_Distro.ISO`. Later executions reuse the existing file. To use a
different ISO, override `TEMPLEOS_ISO`:

    make qemu-iso TEMPLEOS_ISO=/path/to/TempleOS.iso

The download can also be performed explicitly with `make download-iso`.

The Makefile does not generate a TempleOS bootable image on Linux: TempleOS
uses its own RedSea image format and its kernel/compiler are built inside
TempleOS. `xorriso` can create ISO9660 images, but those are not replacements
for a bootable TempleOS image.

Lua integration
---------------
The minimal functional HolyC port of Lua is included as the `deps/holylua`
Git submodule:

    git clone --recurse-submodules <repository-url>
    git submodule update --init --recursive

The Linux-side HolyC validation uses `hcc` from the `holyc-lang` project. The
tested local version is `hcc v0.0.15-beta`; install it and make sure `hcc` is
available on `PATH` before compiling HolyC sources. `hcc` is an external build
tool and is intentionally not vendored in this repository.

You can't do much until you burn a TempleOS CD/DVD from the ISO file
and boot it, or you aim your virtual machine's CD/DVD at the ISO file
and boot.  TempleOS files are compressed and the source code can only be 
compiled by the TempleOS compiler... which is available when you boot
the CD/DVD.  TempleOS is 100% open source with all source present.

TempleOS is 64-bit and will not run on 32-bit hardware.

TempleOS requires 512 Meg of RAM minimum.

TempleOS may require you to enter I/O port addresses for the CD/DVD drive
and the hard drive.  In Windows, you can find I/O port info in the
Accessories/System Tools/System Info/Hardware Resources/I/O ports.
Look for and write down "IDE", "ATA" or "SATA" port numbers.  In Linux, use
"lspci -v".  Then, boot the TempleOS CD and try all combinations.  (Sorry,
it's too difficult for TempleOS to figure-out port numbers, automatically.)

The source code can also be found at the TempleOS web site, 
http://www.templeos.org but cannot be compiled outside TempleOS because
it's HolyC, a nonstandard C/C++ dialect, and asm.
