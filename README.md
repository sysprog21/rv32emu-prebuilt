# The test suite for [rv32emu project](https://github.com/sysprog21/rv32emu)

## Prerequisites

This test suite relies RISC-V GNU toolchain to build the ELF files. See the [prerequisites section](https://github.com/riscv-collab/riscv-gnu-toolchain?tab=readme-ov-file#prerequisites) of RISC-V GNU toolchain.

## Build ELFs

Run `make` to build the binaries.
The default enabled extensions of RISC-V are `rv32gc` (a.k.a. rv32imafdc) and the optimization levels are `O0, O1, O2`.
These two options can be overrided by the argument `RV32_EXT` and `OPT_LEVEL`.

```shell
$ make [RV32_EXT=<rv32_ext>] [OPT_LEVEL=<opt_level>]
```

The `RV32_EXT` takes the same value that passing to `--with-arch` of the RISC-V GNU toolchain, and the `OPT_LEVEL` takes the combination of the whitespace separated number of 0, 1, 2 and quoted with the (double) quotation marks.

e.g.

```shell
$ make RV32_EXT=rv32im OPT_LEVEL="0 2"
```

Notice that the above command will build the corresponding toolchain first if it doesn't exist and might take a few time.
You can set the `--jobs (-j)` option to enable the parallel build.

---

The built binaries will be placed in the corresponding subdirectories under the `build` directory.

```
rv32emu-prebuilt/
+-- build/
|   +-- <RV32_EXT>/
|       +-- O0/
|       |   ...
|       |
|       +-- O1/
|       |   ...
|       |
|       +-- O2/
|       |   ...
|
+-- ...
```
