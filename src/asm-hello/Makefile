RV32_EXT ?= rv32gc
OPT_LEVEL ?= 0 1 2

ASFLAGS := -march=$(RV32_EXT) -mabi=ilp32
LDFLAGS := --oformat=elf32-littleriscv

CURDIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
SRC_DIR := $(CURDIR)

# prevent lazy set
ifeq ($(BUILD_DIR),)
  BUILD_DIR := $(CURDIR)/build
endif

SRCS := hello.S
EXECUTABLES := hello.elf

SHELL_HACK := $(shell mkdir -p $(foreach LEVEL,$(OPT_LEVEL),$(BUILD_DIR)/$(RV32_EXT)/O$(LEVEL)/asm-hello))

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

# RISC-V assembler doesn't support "-O" option currently

build-O0: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O0/asm-hello/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O0/asm-hello/%.elf: $(SRC_DIR)/%.S | build-toolchain
	$(VECHO) "  RISCVAS\t$(patsubst $(abspath $(BUILD_DIR)/..)/%.elf,%.o,$@)\n"
	$(Q)$(RV32_PREFIX)as -o $(patsubst %.elf,%.o,$@) -R $(ASFLAGS) $<
	$(VECHO) "  RISCVLD\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n"
	$(Q)$(RV32_PREFIX)ld -o $@ -T $(SRC_DIR)/hello.ld -O0 $(LDFLAGS) $(patsubst %.elf,%.o,$@)

build-O1: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O1/asm-hello/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O1/asm-hello/%.elf: $(SRC_DIR)/%.S | build-toolchain
	$(VECHO) "  RISCVAS\t$(patsubst $(abspath $(BUILD_DIR)/..)/%.elf,%.o,$@)\n"
	$(Q)$(RV32_PREFIX)as -o $(patsubst %.elf,%.o,$@) -R $(ASFLAGS) $<
	$(VECHO) "  RISCVLD\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n"
	$(Q)$(RV32_PREFIX)ld -o $@ -T $(SRC_DIR)/hello.ld -O1 $(LDFLAGS) $(patsubst %.elf,%.o,$@)

build-O2: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O2/asm-hello/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O2/asm-hello/%.elf: $(SRC_DIR)/%.S | build-toolchain
	$(VECHO) "  RISCVAS\t$(patsubst $(abspath $(BUILD_DIR)/..)/%.elf,%.o,$@)\n"
	$(Q)$(RV32_PREFIX)as -o $(patsubst %.elf,%.o,$@) -R $(ASFLAGS) $<
	$(VECHO) "  RISCVLD\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n"
	$(Q)$(RV32_PREFIX)ld -o $@ -T $(SRC_DIR)/hello.ld -O2 $(LDFLAGS) $(patsubst %.elf,%.o,$@)

clean:
	$(RM) $(foreach LEVEL,$(OPT_LEVEL),$(BUILD_DIR)/$(RV32_EXT)/O$(LEVEL)/asm-hello/*)
