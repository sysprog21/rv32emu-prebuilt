RV32_EXT ?= rv32gc
OPT_LEVEL ?= 0 1 2

CURDIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
SRC_DIR := $(CURDIR)/src

CFLAGS := -std=c99 -I$(CURDIR)/include
CFLAGS += \
  -DCOMPILER_FLAGS="\"-std=c99\"" \
  -DMEM_LOCATION="\"Main memory (heap)\"" \
  -DPERFORMANCE_RUN=1 \
  -DITERATIONS=80000 \
  -DUINTPTR_TYPE \
  -DPRINT_CRC

# prevent lazy set
ifeq ($(BUILD_DIR),)
  BUILD_DIR := $(CURDIR)/build
endif

SRCS := \
  core_main.c \
  core_matrix.c \
  core_list_join.c \
  core_state.c \
  core_util.c \
  core_portme.c

EXECUTABLES := coremark.elf

SHELL_HACK := $(shell mkdir -p $(foreach LEVEL,$(OPT_LEVEL),$(BUILD_DIR)/$(RV32_EXT)/O$(LEVEL)/coremark))

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

build-O0: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O0/coremark/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O0/coremark/$(EXECUTABLES): $(addprefix $(SRC_DIR)/,$(SRCS)) | build-toolchain
	$(VECHO) "  RISCVCC\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n"
	$(Q)$(CROSS_COMPILE) -o $@ -O0 $(CFLAGS) $(addprefix $(SRC_DIR)/,$(SRCS))

build-O1: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O1/coremark/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O1/coremark/$(EXECUTABLES): $(addprefix $(SRC_DIR)/,$(SRCS)) | build-toolchain
	$(VECHO) "  RISCVCC\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n"
	$(Q)$(CROSS_COMPILE) -o $@ -O1 $(CFLAGS) $(addprefix $(SRC_DIR)/,$(SRCS))

build-O2: $(addprefix $(BUILD_DIR)/$(RV32_EXT)/O2/coremark/,$(EXECUTABLES))

$(BUILD_DIR)/$(RV32_EXT)/O2/coremark/$(EXECUTABLES): $(addprefix $(SRC_DIR)/,$(SRCS)) | build-toolchain
	$(VECHO) "  RISCVCC\t$(patsubst $(abspath $(BUILD_DIR)/..)/%,%,$@)\n"
	$(Q)$(CROSS_COMPILE) -o $@ -O2 $(CFLAGS) $(addprefix $(SRC_DIR)/,$(SRCS))

clean:
	$(RM) $(foreach LEVEL,$(OPT_LEVEL),$(BUILD_DIR)/$(RV32_EXT)/O$(LEVEL)/coremark/*)
