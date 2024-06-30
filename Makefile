# TODO: check unsupported extensions
RV32_EXT ?= rv32i
OPT_LEVEL := 0 1 2

CFLAGS := -std=c99
LDFLAGS := -lsemihost -lm

CURDIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
SRC_DIR := $(CURDIR)/src
BUILD_DIR := $(CURDIR)/build

SRCS := \
  captcha.c \
  fcalc.c \
  mandelbrot.c \
  nqueens.c \
  nyancat.c \
  pi.c \
  puzzle.c \
  qrcode.c \
  richards.c \
  spirograph.c

ifneq ($(findstring f,$(RV32_EXT)),)
  SRCS += \
    ieee754.c
endif

EXECUTABLES := $(SRCS:%.c=%.elf)

SHELL_HACK := $(shell mkdir -p $(foreach LEVEL,$(OPT_LEVEL),$(BUILD_DIR)/$(RV32_EXT)/O$(LEVEL)))

.PHONY: all clean distclean build-O0 build-O1 build-O2

ifneq ($(filter $(OPT_LEVEL), 0),)
all: build-O0
endif

ifneq ($(filter $(OPT_LEVEL), 1),)
all: build-O1
endif

ifneq ($(filter $(OPT_LEVEL), 2),)
all: build-O2
endif

all:
	$(Q)$(MAKE) -C src/asm-hello BUILD_DIR="$(BUILD_DIR)" RV32_EXT=$(RV32_EXT) OPT_LEVEL="$(OPT_LEVEL)" all
	$(Q)$(MAKE) -C src/ansibench/nbench BUILD_DIR="$(BUILD_DIR)" RV32_EXT=$(RV32_EXT) OPT_LEVEL="$(OPT_LEVEL)" all

include mk/common.mk
include mk/toolchain.mk

build-O0: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O0/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O0/%.elf: $(SRC_DIR)/%.c | build-toolchain
	$(VECHO) "  RISCVCC\t$(patsubst $(abspath $(SRC_DIR)/..)/%,%,$@)\n"
	$(Q)$(CROSS_COMPILE) -o $@ -O0 $(CFLAGS) $< $(LDFLAGS)

build-O1: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O1/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O1/%.elf: $(SRC_DIR)/%.c | build-toolchain
	$(VECHO) "  RISCVCC\t$(patsubst $(abspath $(SRC_DIR)/..)/%,%,$@)\n"
	$(Q)$(CROSS_COMPILE) -o $@ -O1 $(CFLAGS) $< $(LDFLAGS)

build-O2: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O2/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O2/%.elf: $(SRC_DIR)/%.c | build-toolchain
	$(VECHO) "  RISCVCC\t$(patsubst $(abspath $(SRC_DIR)/..)/%,%,$@)\n"
	$(Q)$(CROSS_COMPILE) -o $@ -O2 $(CFLAGS) $< $(LDFLAGS)

clean:
	$(RM) -r $(foreach LEVEL,$(OPT_LEVEL),$(BUILD_DIR)/$(RV32_EXT)/O$(LEVEL)/*)

distclean: clean
	$(RM) -r $(BUILD_DIR)/*
	$(RM) -r $(RISCV_TOOLCHAIN_DIR)/build/*
	$(Q)$(MAKE) -C $(RISCV_TOOLCHAIN_DIR) distclean
