TOPDIR			:=$(dir $(abspath $(firstword $(MAKEFILE_LIST))))
WORKSPACE		:=$(TOPDIR)
OUTPUT			:=$(TOPDIR)/build
# TOOLCHAIN		:=aarch64-none-linux-gnu
TOOLCHAIN		:=aarch64-none-linux-llvm
CMAKE			:=cmake
NPROC			?=$(shell nproc)
V				?=0

ifneq ($(TOOLCHAIN),)
    CMAKE_FLAGS	+=-DCMAKE_TOOLCHAIN_FILE=$(TOPDIR)/script/toolchain/$(TOOLCHAIN).cmake
endif

ifneq ($(V),0)
    VERBOSE	:=-v
endif

phony+=config
config:
	$(CMAKE) $(CMAKE_FLAGS) -S$(WORKSPACE) -B$(OUTPUT)

phony+=build
build:
	$(CMAKE) --build $(OUTPUT) -j $(NPROC) $(VERBOSE)

phony+=clean
clean:
	$(CMAKE) --build $(OUTPUT) --target clean $(VERBOSE)

phony+=distclean
distclean:
	rm -rf $(OUTPUT)

.PHONY: $(phony)
