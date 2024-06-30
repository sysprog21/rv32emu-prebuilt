RV32_EXT ?= rv32gc
OPT_LEVEL ?= 0 1 2

CURDIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
SRC_DIR := $(CURDIR)/src

CFLAGS := -c -std=c99 -I$(CURDIR)/include
LDFLAGS := -lm

# prevent lazy set if not providing initial value
ifeq ($(BUILD_DIR),)
  BUILD_DIR := $(CURDIR)/build
endif

SRCS := \
  misc.c \
  sysspec.c \
  emfloat.c \
  nbench1.c \
  nbench0.c

OBJS := $(SRCS:%.c=%.o)

EXECUTABLES := nbench.elf

SHELL_HACK := $(shell mkdir -p $(foreach LEVEL,$(OPT_LEVEL),$(BUILD_DIR)/$(RV32_EXT)/O$(LEVEL)/nbench))

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

include ../../../mk/common.mk
include ../../../mk/toolchain.mk

build-O0: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O0/nbench/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O0/nbench/$(EXECUTABLES): $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O0/nbench/,$(OBJS))
	$(VECHO) "  RISCVLD\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n" 
	$(Q)$(CROSS_COMPILE) -o $@ -O0 $^ $(LDFLAGS)

$(BUILD_DIR)/$(RV32_EXT)/O0/nbench/%.o: $(SRC_DIR)/%.c | build-toolchain
	$(VECHO) "  RISCVCC\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n"
	$(Q)$(CROSS_COMPILE) -o $@ -O0 $(CFLAGS) $<

build-O1: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O1/nbench/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O1/nbench/$(EXECUTABLES): $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O1/nbench/,$(OBJS))
	$(VECHO) "  RISCVLD\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n" 
	$(Q)$(CROSS_COMPILE) -o $@ -O1 $^ $(LDFLAGS)

$(BUILD_DIR)/$(RV32_EXT)/O1/nbench/%.o: $(SRC_DIR)/%.c | build-toolchain
	$(VECHO) "  RISCVCC\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n"
	$(Q)$(CROSS_COMPILE) -o $@ -O1 $(CFLAGS) $<

build-O2: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O2/nbench/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O2/nbench/$(EXECUTABLES): $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O2/nbench/,$(OBJS))
	$(VECHO) "  RISCVLD\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n" 
	$(Q)$(CROSS_COMPILE) -o $@ -O2 $^ $(LDFLAGS)

$(BUILD_DIR)/$(RV32_EXT)/O2/nbench/%.o: $(SRC_DIR)/%.c | build-toolchain
	$(VECHO) "  RISCVCC\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n"
	$(Q)$(CROSS_COMPILE) -o $@ -O2 $(CFLAGS) $<

clean:
	$(RM) $(foreach LEVEL,$(OPT_LEVEL),$(BUILD_DIR)/$(RV32_EXT)/O$(LEVEL)/nbench/*)
