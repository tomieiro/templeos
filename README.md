# TempleOS

This repository preserves the TempleOS source code and adds tools for
inspecting, packaging, and booting the system from a Linux host. It also
integrates an experimental Lua core written in HolyC.

The project brings together four distinct sets of material:

- the normalized TempleOS source tree under `src/`;
- the original documentation under `docs/templeos/`;
- historical bootstrap artifacts under `bootstrap/`;
- recent Linux, RedSea, QEMU, and Lua tooling and integrations.

> **Important:** the TempleOS compiler and kernel remain HolyC programs
> intended to run inside TempleOS itself. The Linux build prepares images,
> compiles supporting tools, and validates HolyC files with `hcc`; it is not a
> complete cross-compiler for the operating system.

## Current status

The repository can currently:

- build the Linux `TOSZ` utility;
- validate the Lua launcher and entry point with `hcc`;
- assemble a source tree ready to be transferred into TempleOS;
- create a conventional source ISO;
- create a bootable image with RedSea and El Torito structures;
- boot the historical V5.03 tree and expose the Lua core through the menu;
- boot an existing TempleOS ISO or attach this repository's source ISO to an
  existing disk image.

The RedSea image reaches the TempleOS desktop and contains the Lua launcher.
Native compilation and development of the complete Lua port still take place
inside the guest and should not be confused with a complete Lua implementation.

## Repository layout

```text
src/                         normalized TempleOS source code
  adam/                      environment, shell, and high-level subsystems
  apps/                      applications and the Lua launcher
  compiler/                  HolyC compiler
  demo/                      demonstrations and games
  kernel/                    kernel, boot code, and fundamental libraries
  misc/                      assorted data and utilities
docs/templeos/               original system documentation
tools/linux/tosz.cpp         host-side TOSZ utility
tools/linux/redsea.py        RedSea/El Torito image generator
bootstrap/templeos-2013/     historical 2013 bootstrap seed
bootstrap/templeos-v5.03/    historical runtime used by the current image
deps/holylua/                experimental Lua port, as a Git submodule
makefile                     build, preparation, and QEMU commands
aicp.aicp                    semantic map for development agents
LICENSE                      repository-wide terms
NOTICE                       third-party attributions and unresolved issues
```

All locally generated output is stored under `build/`, which is ignored by
Git.

## Requirements

The exact requirements depend on the target:

| Tool | Used for |
| --- | --- |
| GNU Make and a C++11 compiler | building `TOSZ` |
| Python 3 | generating the RedSea image |
| `hcc` from the `holyc-lang` project | validating HolyC files on Linux |
| `genisoimage` | creating the source ISO |
| x86_64 QEMU | booting images and ISOs |
| KVM | acceleration used by the `qemu` and `qemu-iso` targets |
| `curl` | downloading the ISO configured by the Makefile |

Development was validated with `hcc v0.0.15-beta`. This program is an external
dependency and is not vendored in the repository.

TempleOS is an x86_64 operating system and requires at least 512 MiB of RAM.
On physical hardware, IDE/ATA I/O ports may need to be entered manually.

## Cloning

The Lua port is a submodule. Clone the repository recursively:

```sh
git clone --recurse-submodules https://github.com/tomieiro/templeos.git
cd templeos
```

If the repository was already cloned without submodules:

```sh
git submodule update --init --recursive
```

## Build commands

### Default validation

```sh
make
```

The default target runs `make check`, which:

1. builds `tools/linux/tosz.cpp` as `build/host/tosz`;
2. compiles `src/apps/lua_interpreter.hc` and the Lua entry point with `hcc`
   for validation;
3. runs a minimal check against the `TOSZ` binary.

This command does not rebuild the TempleOS kernel or compiler.

### Host utility only

```sh
make host
```

This creates `build/host/tosz`. `TOSZ` handles the compression format used by
TempleOS files; it is a supporting utility, not a HolyC compiler.

### Prepare the source tree

```sh
make prepare
```

This creates `build/templeos/` containing:

- the `src/` tree;
- the Lua submodule sources;
- the Lua launcher with its path adjusted for the prepared layout;
- `LICENSE`, `NOTICE`, and the Lua license.

The resulting tree can be copied or mounted inside a TempleOS environment for
native compilation.

### Create a source ISO

```sh
make source-iso
```

This runs `prepare` and creates `build/templeos-source.iso` with
`genisoimage`. It is a source transport ISO, not a bootable TempleOS image.

### Create the bootable RedSea image

```sh
make redsea-image
```

This creates `build/templeos-redsea.iso`. The process:

1. validates the HolyC entry points;
2. copies the historical tree extracted from the matching V5.03 ISO;
3. injects the Lua/HolyC runtime and rewrites its includes to use absolute
   TempleOS paths;
4. adds the launcher and a minimal `PersonalMenu.DD.Z`;
5. includes the license and notice files;
6. writes the RedSea file system and the El Torito boot records.

Despite its `.iso` extension, this artifact is written directly by the
project's RedSea generator. It is not equivalent to the ISO9660 image produced
by `source-iso`.

Boot it manually with:

```sh
qemu-system-x86_64 \
  -m 512M \
  -cdrom build/templeos-redsea.iso \
  -boot d
```

Add `-enable-kvm -cpu qemu64` when KVM is available and appropriate for the
host.

### Clean generated output

```sh
make clean
```

This removes the entire `build/` directory.

## QEMU workflows

There are three distinct workflows. Choosing the correct one avoids confusing
a source ISO, a disk image, and bootable media.

### Boot the generated RedSea image

Run `make redsea-image`, then use the QEMU command shown above. There is no
dedicated Make target for booting this file.

### Use an existing TempleOS disk image

```sh
make qemu TEMPLEOS_IMAGE=/path/to/templeos.img
```

This target creates `build/templeos-source.iso`, boots the specified file as an
IDE disk, and attaches the source ISO as a second CD-ROM. The disk image must
already exist; the Makefile does not create or format it.

### Boot an existing TempleOS ISO

```sh
make qemu-iso
```

On its first run, the Makefile downloads the configured media to
`build/TOS_Distro.ISO`; later runs reuse it. To use a different image:

```sh
make qemu-iso TEMPLEOS_ISO=/path/to/TempleOS.iso
```

The download can also be run separately with `make download-iso`.

## Historical bootstrap

TempleOS uses its own formats and depends on binaries generated by its own
compiler. For that reason, `bootstrap/` preserves a historical chain capable
of starting the environment in which newer versions can be compiled.

- `templeos-2013/` contains the MBR, kernel handoff, CD boot record, MHD2 boot
  code, and compiler recovered from snapshot `17b71f1`
  (`TempleOSTS_130315.ISO`).
- `templeos-v5.03/` contains the matching kernel/compiler pair from commit
  `1dd8859`, together with the RedSea tree extracted from the V5.03 ISO whose
  SHA-1 is `1a1ec79990e21fa3d66ac680009da63d3ac512b0`.

The `redsea-image` target uses the V5.03 tree. The 2013 artifacts are preserved
as recovery material and do not participate in this target. See
[`bootstrap/README.md`](bootstrap/README.md) for details.

## Lua integration

`deps/holylua` is an independent, experimental port based on Lua 5.4.9. The
main launcher is `src/apps/lua_interpreter.hc`, which includes the submodule's
entry point. During RedSea image generation, the files are installed under
`::/Apps/Lua/`, and the personal menu receives a direct interpreter entry.

The current core implements a useful language subset, including scalar values,
control flow, functions, recursion, and fixed-capacity numeric tables. It is
not yet the complete Lua runtime: missing pieces include closures, upvalues,
string keys, multiple return values, and full integration of the VM, parser,
garbage collector, and libraries.

See [`deps/holylua/README.md`](deps/holylua/README.md) and
[`deps/holylua/docs/port-status.md`](deps/holylua/docs/port-status.md) for the
detailed status and port-specific tests.

## Important details

- HolyC is not conventional C or C++; compatibility with `hcc` on Linux does
  not replace testing inside TempleOS.
- The `src/` tree uses normalized lowercase names. The historical V5.03 tree
  preserves the original capitalization and compressed `.Z` files.
- RedSea is not an ISO9660 file system. The generator preserves contiguous
  files, directories, and the allocation bitmap in the format TempleOS expects.
- The bootstrap image combines compatible historical artifacts. Mixing kernel,
  compiler, or boot records from different versions can prevent booting.
- The original TempleOS has no networking. Downloads and dependency preparation
  take place on the host.
- Generated files use the host clock for RedSea directory entries, so identical
  source trees alone do not guarantee byte-for-byte reproducible builds.

## Licensing and provenance

The original TempleOS was released into the public domain by Terry A. Davis.
The Lua submodule has its own permissive license, which must accompany
redistributions.

The repository also preserves historical third-party material whose permission
or licensing is not fully documented. Before redistributing the complete tree
as a product that requires full rights clearance, read:

- [`LICENSE`](LICENSE) for the repository-wide terms;
- [`NOTICE`](NOTICE) for attributions, exceptions, and known unresolved issues;
- [`docs/templeos/credits.dd`](docs/templeos/credits.dd) for the original
  TempleOS credits.

## Development

When changing the architecture, commands, build contracts, or invariants,
update `aicp.aicp` as well. Preserve the historical artifacts under
`bootstrap/`, and make integration changes in the sources, tools, or build
recipes that produce them. Do not commit anything under `build/`.
