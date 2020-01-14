# builder
FROM centos:7

RUN yum install autoconf automake libmpc-devel mpfr-devel gmp-devel gawk  bison flex texinfo patchutils gcc gcc-c++ zlib-devel expat-devel -y
RUN yum install make file -y
RUN yum install gtk2-devel -y
WORKDIR /riscv-gnu-toolchain

# ENTRYPOINT ["/bin/bash"]
