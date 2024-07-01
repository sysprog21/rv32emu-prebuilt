RV32_EXT ?= rv32gc
OPT_LEVEL ?= 0 1 2

CURDIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
SRC_DIR := $(CURDIR)/src

CFLAGS := -std=c99
CXXFLAGS :=
LDFLAGS := -lm

# prevent lazy set
ifeq ($(BUILD_DIR),)
  BUILD_DIR := $(CURDIR)/build
endif

SRCS := \
  aes.c \
  dhrystone.c \
  miniz.c \
  norx.c \
  primes.c \
  qsort.c \
  sha512.c

EXECUTABLES := $(SRCS:%.c=%.elf)

SHELL_HACK := $(shell mkdir -p $(foreach LEVEL,$(OPT_LEVEL),$(BUILD_DIR)/$(RV32_EXT)/O$(LEVEL)/rv8-bench))

.PHONY: all clean build-O0 build-O1 build-O2

ifneq ($(filter $(OPT_LEVEL), 0),)
all: build-O0 $(BUILD_DIR)/$(RV32_EXT)/O0/rv8-bench/bigint.elf
endif

ifneq ($(filter $(OPT_LEVEL), 1),)
all: build-O1 $(BUILD_DIR)/$(RV32_EXT)/O1/rv8-bench/bigint.elf
endif

ifneq ($(filter $(OPT_LEVEL), 2),)
all: build-O2 $(BUILD_DIR)/$(RV32_EXT)/O2/rv8-bench/bigint.elf
endif

include ../../mk/common.mk
include ../../mk/toolchain.mk

build-O0: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O0/rv8-bench/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O0/rv8-bench/%.elf: $(SRC_DIR)/%.c | build-toolchain
	$(VECHO) "  RISCVCC\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n"
	$(Q)$(CROSS_COMPILE) -o $@ -O0 $(CFLAGS) $< $(LDFLAGS)

$(BUILD_DIR)/$(RV32_EXT)/O0/rv8-bench/bigint.elf: $(SRC_DIR)/bigint.cc | build-toolchain
	$(VECHO) "  RISCVCXX\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n"
	$(Q)$(RV32_PREFIX)g++ -o $@ -O0 $(CXXFLAGS) $<

build-O1: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O1/rv8-bench/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O1/rv8-bench/%.elf: $(SRC_DIR)/%.c | build-toolchain
	$(VECHO) "  RISCVCC\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n"
	$(Q)$(CROSS_COMPILE) -o $@ -O1 $(CFLAGS) $< $(LDFLAGS)

$(BUILD_DIR)/$(RV32_EXT)/O1/rv8-bench/bigint.elf: $(SRC_DIR)/bigint.cc | build-toolchain
	$(VECHO) "  RISCVCXX\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n"
	$(Q)$(RV32_PREFIX)g++ -o $@ -O1 $(CXXFLAGS) $<

build-O2: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O2/rv8-bench/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O2/rv8-bench/%.elf: $(SRC_DIR)/%.c | build-toolchain
	$(VECHO) "  RISCVCC\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n"
	$(Q)$(CROSS_COMPILE) -o $@ -O2 $(CFLAGS) $< $(LDFLAGS)

$(BUILD_DIR)/$(RV32_EXT)/O2/rv8-bench/bigint.elf: $(SRC_DIR)/bigint.cc | build-toolchain
	$(VECHO) "  RISCVCXX\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n"
	$(Q)$(RV32_PREFIX)g++ -o $@ -O2 $(CXXFLAGS) $<

clean:
	$(RM) $(foreach LEVEL,$(OPT_LEVEL),$(BUILD_DIR)/$(RV32_EXT)/O$(LEVEL)/rv8-bench/*)
