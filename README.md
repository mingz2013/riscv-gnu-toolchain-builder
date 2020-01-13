# riscv-gnu-toolchains
riscv-gnu-toolchains



## build tool chains

- `make git-clone`
- `make builder`
- `make tool-chain`


## use
`docker run --rm -v "$PWD"/app:/usr/src/myapp -w /usr/src/myapp mingz2013/riscv-gnu-toolchain:1.0 /riscv/bin/riscv64-unknown-elf-gcc -o myapp hello.c`


# reference
- https://github.com/riscv/riscv-gnu-toolchain