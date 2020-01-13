.PHONY: help
help:
	@echo '                                                                          '
	@echo 'Makefile for gitbook doc                                                  '
	@echo '                                                                          '
	@echo 'Usage:                                                                    '
	@echo '   make help                           show help                          '
	@echo '                                                                          '
	@echo '   make builder                        builder image                      '
	@echo '   make copy                           copy                               '
	@echo '   make tool-chain                    tool chain image                  '
	@echo '                                                                          '
	@echo '                                                                          '


BUILDER := mingz2013/riscv-gnu-toolchain-builder:1.0
BUILDER-1 := mingz2013/riscv-gnu-toolchain-builder-1:1.0
TOOL := mingz2013/riscv-gnu-toolchain:1.0

BASEDIR=$(CURDIR)

RISCV := $(BASEDIR)/riscv
RISCV-SRC := $(BASEDIR)/src/riscv-gnu-toolchain

RISCV-IN := /opt/riscv
RISCV-SRC-IN := /riscv-gnu-toolchain


DOCKER-RUN := docker run -i -t -v${RISCV}:${RISCV-IN} -v${RISCV-SRC}:${RISCV-SRC-IN} ${BUILDER}

.PHONY: git-clone
git-clone:
	git clone --recursive https://github.com/riscv/riscv-gnu-toolchain ${RISCV-SRC}

.PHONY: builder
builder:
	docker build ./builder -t ${BUILDER}
	docker push ${BUILDER}

.PHONY: build-make-newlib
build-make-newlib: builder
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} && ${DOCKER-RUN} make
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} && ${DOCKER-RUN} make report-newlib

.PHONY: build-make-linux
build-make-linux: builder
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} && ${DOCKER-RUN} make linux
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} && ${DOCKER-RUN} make report-linux


.PHONY: build-make-linux-32
build-make-linux-32: builder
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --with-arch=rv32gc --with-abi=ilp32d && ${DOCKER-RUN} make linux
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --with-arch=rv32gc --with-abi=ilp32d && ${DOCKER-RUN} make report-linux

.PHONY: build-make-linux-multilib
build-make-linux-multilib: builder
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --enable-multilib && ${DOCKER-RUN} make linux
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --enable-multilib && ${DOCKER-RUN} make report-linux

.PHONY: build-make-newlib-64
build-make-newlib-64: builder
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --disable-linux --with-arch=rv64ima && ${DOCKER-RUN} make newlib
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --disable-linux --with-arch=rv64ima && ${DOCKER-RUN} make report-newlib

.PHONY: build-make-newlib-32
build-make-newlib-32: builder
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --disable-linux --with-arch=rv32ima && ${DOCKER-RUN} make newlib
	${DOCKER-RUN} ./configure --prefix=${RISCV-IN} --disable-linux --with-arch=rv32ima && ${DOCKER-RUN} make report-newlib

.PHONY: build
build: build-make-newlib build-make-newlib-32 build-make-linux-multilib build-make-linux-32


.PHONY: tool-chain
tool-chain: build
	docker build . -t ${TOOL}
	docker push ${TOOL}


.PHONY: builder-1
builder-1:
	docker build ./builder-1 -t ${BUILDER-1}
	docker push ${BUILDER-1}

.PHONY: copy
copy: builder-1
	docker run -i -t  -v./riscv:/riscv ${BUILDER-1} /bin/bash copy /opt/riscv /riscv -r


.PHONY: tool-chain-1
tool-chain-1: copy
	docker build . -t ${TOOL}
	docker push ${TOOL}



