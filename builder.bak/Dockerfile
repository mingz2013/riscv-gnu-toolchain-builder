# builder
FROM centos:7

RUN yum install git -y

# RUN git clone --recursive https://github.com/riscv/riscv-gnu-toolchain /riscv-gnu-toolchain
RUN git clone https://github.com/riscv/riscv-gnu-toolchain /riscv-gnu-toolchain
RUN cd /riscv-gnu-toolchain && git submodule update --init --recursive

RUN yum install autoconf automake libmpc-devel mpfr-devel gmp-devel gawk  bison flex texinfo patchutils gcc gcc-c++ zlib-devel expat-devel -y
RUN yum install make file -y

ENV RISCV=/opt/riscv

WORKDIR /riscv-gnu-toolchain

RUN ./configure --prefix=$RISCV
RUN make
RUN make linux
RUN make report-linux

RUN ./configure --prefix=$RISCV --with-arch=rv32gc --with-abi=ilp32d
RUN make linux

RUN ./configure --prefix=$RISCV --enable-multilib
RUN make linux
RUN make report-linux

RUN ./configure --prefix=$RISCV --disable-linux --with-arch=rv64ima # or --with-arch=rv32ima
RUN make newlib
RUN make report-newlib


RUN ./configure --prefix=$RISCV --disable-linux --with-arch=rv32ima # or --with-arch=rv64ima
RUN make newlib
RUN make report-newlib

# ENTRYPOINT ["/bin/bash"]
