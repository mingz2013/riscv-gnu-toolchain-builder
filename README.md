# riscv-gnu-toolchains
riscv-gnu-toolchains



## build tool chains

- `make git-clone`
- `make builder`
- `make tool-chain`
- `make build` # build all


不建议构建所有，我试过了，太慢，太大，没有必要。  
建议构建需要的组合方式。



## use
`docker run --rm -v "$PWD"/app:/usr/src/myapp -w /usr/src/myapp mingz2013/riscv-gnu-toolchain:1.0 /riscv/bin/riscv64-unknown-elf-gcc -o myapp hello.c`


# reference
- https://github.com/riscv/riscv-gnu-toolchain
