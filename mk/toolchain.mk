RV32_PREFIX := riscv32-unknown-elf-

CURDIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/..)
RISCV_TOOLCHAIN_DIR := $(CURDIR)/riscv-gnu-toolchain
SHELL_HACK := $(shell mkdir -p $(RISCV_TOOLCHAIN_DIR)/build/$(RV32_EXT))

CROSS_COMPILE := $(shell find $(RISCV_TOOLCHAIN_DIR)/build/$(RV32_EXT) -name $(RV32_PREFIX)gcc)

.PHONY: build-toolchain

build-toolchain:
  ifeq ($(CROSS_COMPILE),)
	git submodule update --init $(RISCV_TOOLCHAIN_DIR)
	cd $(RISCV_TOOLCHAIN_DIR) && ./configure \
      --prefix=$(RISCV_TOOLCHAIN_DIR)/build/$(RV32_EXT) \
      --with-arch=$(RV32_EXT) \
      --with-abi=ilp32 \
      --disable-gdb
	$(MAKE) -C $(RISCV_TOOLCHAIN_DIR) clean all
  endif
