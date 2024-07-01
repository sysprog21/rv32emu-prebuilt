RV32_EXT ?= rv32gc
OPT_LEVEL ?= 0 1 2

CURDIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
SRC_DIR := $(CURDIR)

CFLAGS := -std=c99

# prevent lazy set
ifeq ($(BUILD_DIR),)
  BUILD_DIR := $(CURDIR)/build
endif

EXECUTABLES := cc.elf

SHELL_HACK := $(shell mkdir -p $(foreach LEVEL,$(OPT_LEVEL),$(BUILD_DIR)/$(RV32_EXT)/O$(LEVEL)/cc))

.PHONY: all clean build-O0 build-O1 build-O2

ifneq ($(filter $(OPT_LEVEL), 0),)
all: build-O0
endif

ifneq ($(filter $(OPT_LEVEL), 1),)
all: build-O1
endif

ifneq ($(filter $(OPT_LEVEL), 2),)
all: build-O2
endif

include ../../mk/common.mk
include ../../mk/toolchain.mk

build-O0: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O0/cc/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O0/cc/$(EXECUTABLES): $(SRC_DIR)/cc.c | build-toolchain
	$(VECHO) "  RISCVCC\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n" 
	$(Q)$(CROSS_COMPILE) -o $@ -O0 $(CFLAGS) $<

build-O1: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O1/cc/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O1/cc/$(EXECUTABLES): $(SRC_DIR)/cc.c | build-toolchain
	$(VECHO) "  RISCVCC\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n" 
	$(Q)$(CROSS_COMPILE) -o $@ -O1 $(CFLAGS) $<

build-O2: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O2/cc/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O2/cc/$(EXECUTABLES): $(SRC_DIR)/cc.c | build-toolchain
	$(VECHO) "  RISCVCC\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n" 
	$(Q)$(CROSS_COMPILE) -o $@ -O2 $(CFLAGS) $<

clean:
	$(RM) $(foreach LEVEL,$(OPT_LEVEL),$(BUILD_DIR)/$(RV32_EXT)/O$(LEVEL)/cc/*)
