# builder
FROM centos:7

RUN yum install git -y

# RUN git clone --recursive https://github.com/riscv/riscv-gnu-toolchain
RUN git clone https://github.com/riscv/riscv-gnu-toolchain /riscv-gnu-toolchain
RUN cd /riscv-gnu-toolchain && git submodule update --init --recursive

RUN yum install autoconf automake libmpc-devel mpfr-devel gmp-devel gawk  bison flex texinfo patchutils gcc gcc-c++ zlib-devel expat-devel -y
RUN yum install make file -y

ENV RISCV=/opt/riscv

RUN cd /riscv-gnu-toolchain && ./configure --prefix=$RISCV
RUN cd /riscv-gnu-toolchain && make

RUN cd /riscv-gnu-toolchain && ./configure --prefix=$RISCV
RUN cd /riscv-gnu-toolchain && make linux
RUN cd /riscv-gnu-toolchain && make report-linux

RUN cd /riscv-gnu-toolchain && ./configure --prefix=$RISCV --with-arch=rv32gc --with-abi=ilp32d
RUN cd /riscv-gnu-toolchain && make linux

RUN cd /riscv-gnu-toolchain && ./configure --prefix=$RISCV --enable-multilib
RUN cd /riscv-gnu-toolchain && make linux
RUN cd /riscv-gnu-toolchain && make report-linux

RUN cd /riscv-gnu-toolchain && ./configure --prefix=$RISCV --disable-linux --with-arch=rv64ima # or --with-arch=rv32ima
RUN cd /riscv-gnu-toolchain && make newlib
RUN cd /riscv-gnu-toolchain && make report-newlib


RUN cd /riscv-gnu-toolchain && ./configure --prefix=$RISCV --disable-linux --with-arch=rv32ima # or --with-arch=rv64ima
RUN cd /riscv-gnu-toolchain && make newlib
RUN cd /riscv-gnu-toolchain && make report-newlib

ENTRYPOINT ["/bin/bash"]
