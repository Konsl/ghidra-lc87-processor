# Ghidra LC87 processor extension
Ghidra extension that adds support for the Sanyo LC87 processor

based on https://github.com/chrisnoisel/ghidra/tree/lc87
(but it's a ghidra extension instead of a fork)

**this project is still incomplete.** instruction decoding should (mostly) work,
but anything related to control flow analysis, decompiler, ... does not

## Build Instructions
Builds a Ghidra Extension for a given Ghidra installation. For more info, see `build.gradle`.
```sh
export GHIDRA_INSTALL_DIR=<Absolute path to Ghidra>
gradle
```
or
```sh
gradle -PGHIDRA_INSTALL_DIR=<Absolute path to Ghidra>
```
(default is `/opt/ghidra`)
