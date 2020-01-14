# builder
FROM centos:7

RUN yum install autoconf automake libmpc-devel mpfr-devel gmp-devel gawk  bison flex texinfo patchutils gcc gcc-c++ zlib-devel expat-devel -y
RUN yum install make file -y
RUN yum install gtk2-devel -y
RUN yum install python3 -y

RUN curl -O http://ftp.gnu.org/gnu/make/make-4.2.1.tar.gz && \
    tar -zxvf make-4.2.1.tar.gz && \
    cd make-4.2.1 && \
    ./configure && \
    make && \
    make install && \
    make -v

WORKDIR /riscv-gnu-toolchain/build

# ENTRYPOINT ["/bin/bash"]
