# riscv-gnu-toolchains
riscv-gnu-toolchains



## build tool chains

- `make git-clone`
- `make builder`
- `make tool-chain`
- `make build` # build all


不建议构建所有，我试过了，太慢，太大，没有必要。  
建议构建需要的组合方式。


To build the glibc (Linux) on OS X, you will need to build within a case-sensitive file system. The simplest approach is to create and mount a new disk image with a case sensitive format. Make sure that the mount point does not contain spaces. This is not necessary to build newlib or gcc itself on OS X.

This process will start by downloading about 200 MiB of upstream sources, then will patch, build, and install the toolchain. If a local cache of the upstream sources exists in $(DISTDIR), it will be used; the default location is /var/cache/distfiles. Your computer will need about 8 GiB of disk space to complete the process.


## use
- `docker pull mingz2013/riscv-gnu-toolchain`
- `docker run --rm -v "$PWD"/app:/myapp -w /myapp mingz2013/riscv-gnu-toolchain /riscv/bin/riscv64-unknown-elf-gcc -o myapp hello.c`
- `docker run --rm mingz2013/riscv-gnu-toolchain ls -l /riscv/bin`
- `docker run --rm -v "$PWD"/app:/app -w /app mingz2013/riscv-gnu-toolchain /riscv/bin/riscv64-unknown-elf-gcc -o hello hello.c`
- `docker run --rm -v "$PWD"/app:/app -w /app mingz2013/riscv-gnu-toolchain /riscv/bin/riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -o hello hello.c`
- `docker run --rm -v "$PWD"/app:/app -w /app mingz2013/riscv-gnu-toolchain /riscv/bin/riscv64-unknown-linux-gnu-gcc hello.c`

## docker
- https://hub.docker.com/r/mingz2013/riscv-gnu-toolchain
- https://hub.docker.com/r/mingz2013/riscv-gnu-toolchain-builder

# reference
- https://github.com/riscv/riscv-gnu-toolchain
