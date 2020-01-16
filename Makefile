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
	@echo '   make build-tool-chain                    tool chain image                    '
	@echo '   make build                         build all                           '
	@echo '                                                                          '
	@echo '                                                                          '


BUILDER := mingz2013/riscv-gnu-toolchain-builder:1.0
TOOL := mingz2013/riscv-gnu-toolchain:1.0

BASEDIR=$(CURDIR)

RISCV := $(BASEDIR)/bin/riscv
RISCV-SRC := $(BASEDIR)/src/riscv-gnu-toolchain

RISCV-IN := /opt/riscv
RISCV-SRC-IN := /riscv-gnu-toolchain

RISCV-BUILD-DIR = $(RISCV-SRC)/build

DOCKER-BUILDER-RUN := docker run --rm -i -t -v${RISCV}:${RISCV-IN} -v${RISCV-SRC}:${RISCV-SRC-IN} ${BUILDER}

.PHONY: git-clone
git-clone:
	git clone --recursive https://github.com/riscv/riscv-gnu-toolchain ${RISCV-SRC}
	#git clone https://github.com/riscv/riscv-gnu-toolchain ${RISCV-SRC}
	#cd ${RISCV-SRC} && git submodule update --init --recursive

.PHONY: builder
builder:
	docker build ./builder -t ${BUILDER}
	docker push ${BUILDER}


.PHONY: build-make-multilib
build-make-multilib:
	${DOCKER-BUILDER-RUN} ${RISCV-SRC-IN}/configure --prefix=${RISCV-IN} --enable-multilib
	${DOCKER-BUILDER-RUN} make
	${DOCKER-BUILDER-RUN} make linux
	#${DOCKER-BUILDER-RUN} make report-newlib
	#rm -r ${RISCV-BUILD-DIR}


.PHONY: build-tool-chain
build-tool-chain: build-make-multilib
	docker build ./bin -t ${TOOL}
	#docker push ${TOOL}


.PHONY: build-hello
build-hello:
	docker run --rm -v $(BASEDIR)/app:/app -w /app ${TOOL} /riscv/bin/riscv64-unknown-elf-gcc -o hello hello.c

.PHONY: build
build: git-clone builder build-tool-chain build-hello
