SHELL := /bin/sh

CC ?= c++
CXXFLAGS ?= -O2 -Wall -Wextra -std=c++11
HCC ?= hcc
QEMU ?= qemu-system-x86_64
GENISOIMAGE ?= genisoimage
CURL ?= curl

BUILD_DIR ?= build
HOST_DIR := $(BUILD_DIR)/host
HCC_DIR := $(BUILD_DIR)/hcc
TEMPLEOS_TREE := $(BUILD_DIR)/templeos
TOSZ := $(HOST_DIR)/tosz
REDSEA := tools/linux/redsea.py
BOOTCD := bootstrap/templeos-2013/0000boot/bootcd.bin
TEMPLEOS_IMAGE ?= $(BUILD_DIR)/templeos.img
TEMPLEOS_ISO ?= $(BUILD_DIR)/TOS_Distro.ISO
TEMPLEOS_ISO_URL ?= https://github.com/cia-foundation/TempleOS/releases/download/final/TOS_Distro.ISO
SOURCE_ISO := $(BUILD_DIR)/templeos-source.iso

HOLY_LUA := deps/holylua
LUA_ENTRY := $(HOLY_LUA)/src/templeos/lua.hc
LAUNCHER := src/apps/lua_interpreter.hc

.PHONY: all host hcc-check prepare source-iso redsea-image download-iso check qemu qemu-iso clean tools

all: check

tools: host

host: $(TOSZ)

$(TOSZ): tools/linux/tosz.cpp | $(HOST_DIR)
	$(CC) $(CXXFLAGS) $< -o $@

$(HOST_DIR):
	mkdir -p $@

hcc-check: | $(HCC_DIR)
	@command -v $(HCC) >/dev/null 2>&1 || { echo "error: hcc not found; install holyc-lang" >&2; exit 1; }
	$(HCC) -c -o $(HCC_DIR)/lua_interpreter.o $(LAUNCHER)
	$(HCC) -c -o $(HCC_DIR)/lua_entry.o $(LUA_ENTRY)

$(HCC_DIR):
	mkdir -p $@

prepare: hcc-check
	rm -rf $(TEMPLEOS_TREE)
	mkdir -p $(TEMPLEOS_TREE)/deps/holylua/src
	cp -a src/. $(TEMPLEOS_TREE)/
	cp -a deps/holylua/src/. $(TEMPLEOS_TREE)/deps/holylua/src/
	sed 's#"../../deps/holylua/#"/deps/holylua/#' $(LAUNCHER) > $(TEMPLEOS_TREE)/apps/lua_interpreter.hc

source-iso: prepare
	@command -v $(GENISOIMAGE) >/dev/null 2>&1 || { echo "error: genisoimage not found" >&2; exit 1; }
	$(GENISOIMAGE) -quiet -R -J -V TEMPLEOS_SRC -o $(SOURCE_ISO) $(TEMPLEOS_TREE)

redsea-image: prepare
	mkdir -p $(TEMPLEOS_TREE)/0000boot $(TEMPLEOS_TREE)/compiler
	cp bootstrap/templeos-2013/0000boot/0000kernel.bin.c $(TEMPLEOS_TREE)/0000boot/
	cp bootstrap/templeos-2013/compiler/compiler.bin $(TEMPLEOS_TREE)/compiler/
	python3 $(REDSEA) $(TEMPLEOS_TREE) $(BUILD_DIR)/templeos-redsea.iso --bootcd $(BOOTCD)

download-iso:
	@command -v $(CURL) >/dev/null 2>&1 || { echo "error: curl not found" >&2; exit 1; }
	@test -f "$(TEMPLEOS_ISO)" || { mkdir -p "$(dir $(TEMPLEOS_ISO))"; echo "downloading TempleOS ISO..."; $(CURL) --fail --location --retry 3 --output "$(TEMPLEOS_ISO).tmp" "$(TEMPLEOS_ISO_URL)" && mv "$(TEMPLEOS_ISO).tmp" "$(TEMPLEOS_ISO)" || { status=$$?; rm -f "$(TEMPLEOS_ISO).tmp"; exit $$status; }; }

check: host hcc-check
	$(TOSZ) 2>&1 | grep -q 'TOSZ'

qemu: source-iso
	@test -f "$(TEMPLEOS_IMAGE)" || { echo "error: set TEMPLEOS_IMAGE to an existing TempleOS disk image" >&2; exit 1; }
	$(QEMU) -enable-kvm -m 512M -cpu qemu64 -drive file=$(TEMPLEOS_IMAGE),format=raw,if=ide -drive file=$(SOURCE_ISO),media=cdrom,if=ide,index=1

qemu-iso: download-iso
	$(QEMU) -enable-kvm -m 512M -cpu qemu64 -cdrom $(TEMPLEOS_ISO) -boot d

clean:
	rm -rf $(BUILD_DIR)
