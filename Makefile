.PHONY: help
help:
	@echo '                                                                          '
	@echo 'Makefile for riscv doc                                                    '
	@echo '                                                                          '
	@echo 'Usage:                                                                    '
	@echo '   make help                           show help                          '
	@echo '                                                                          '
	@echo '   make git-clone                     clone source                        '
	@echo '   make builder                       builder image                       '
	@echo '   make tool-chain                    tool chain image                    '
	@echo '                                                                          '
	@echo '                                                                          '


BUILDER := mingz2013/riscv-gnu-toolchain-builder:1.0
TOOL := mingz2013/riscv-gnu-toolchain:1.0

BASEDIR=$(CURDIR)

RISCV := $(BASEDIR)/bin/riscv
RISCV-SRC := $(BASEDIR)/src/riscv-gnu-toolchain

RISCV-IN := /opt/riscv
RISCV-SRC-IN := /riscv-gnu-toolchain


DOCKER-RUN := docker run -i -t -v${RISCV}:${RISCV-IN} -v${RISCV-SRC}:${RISCV-SRC-IN} ${BUILDER}

.PHONY: git-clone
git-clone:
	git clone --recursive https://github.com/riscv/riscv-gnu-toolchain ${RISCV-SRC}
	#git clone https://github.com/riscv/riscv-gnu-toolchain ${RISCV-SRC}
	#cd ${RISCV-SRC} && git submodule update --init --recursive

.PHONY: builder
builder:
	docker build ./builder -t ${BUILDER}
	docker push ${BUILDER}

.PHONY: build-make-newlib
build-make-newlib:
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} && ${DOCKER-RUN} make
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} && ${DOCKER-RUN} make report-newlib

.PHONY: build-make-linux
build-make-linux:
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} && ${DOCKER-RUN} make linux
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} && ${DOCKER-RUN} make report-linux


.PHONY: build-make-linux-32
build-make-linux-32:
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --with-arch=rv32gc --with-abi=ilp32d && ${DOCKER-RUN} make linux
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --with-arch=rv32gc --with-abi=ilp32d && ${DOCKER-RUN} make report-linux

.PHONY: build-make-linux-multilib
build-make-linux-multilib:
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --enable-multilib && ${DOCKER-RUN} make linux
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --enable-multilib && ${DOCKER-RUN} make report-linux

.PHONY: build-make-newlib-64
build-make-newlib-64:
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --disable-linux --with-arch=rv64ima && ${DOCKER-RUN} make newlib
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --disable-linux --with-arch=rv64ima && ${DOCKER-RUN} make report-newlib

.PHONY: build-make-newlib-32
build-make-newlib-32:
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --disable-linux --with-arch=rv32ima && ${DOCKER-RUN} make newlib
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --disable-linux --with-arch=rv32ima && ${DOCKER-RUN} make report-newlib

.PHONY: build
build: build-make-newlib build-make-newlib-32 build-make-linux-multilib build-make-linux-32


.PHONY: tool-chain
tool-chain:
	docker build ./bin -t ${TOOL}
	#docker push ${TOOL}



