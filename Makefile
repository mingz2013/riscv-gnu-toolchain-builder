.PHONY: help
help:
	@echo '                                                                          '
	@echo 'Makefile for gitbook doc                                                  '
	@echo '                                                                          '
	@echo 'Usage:                                                                    '
	@echo '   make help                           show help                          '
	@echo '                                                                          '
	@echo '   make up                             启动服务                            '
	@echo '   make down                           停止服务                            '
	@echo '   make logs                           查看日志                            '
	@echo '                                                                          '
	@echo '                                                                          '


BUILDER := mingz2013/riscv-gnu-toolchains-builder:1.0
TOOL := mingz2013/riscv-gnu-toolchains:1.0
.PHONY: builder
builder:
	docker build ./builder -t ${BUILDER}
	docker pull ${BUILDER}


.PHONY: copy
copy: builder
	docker run -i -t  -v./riscv:/riscv ${BUILDER} /bin/bash copy /opt/riscv /riscv -r


.PHONY: tool-chains
tool-chains: copy
	docker build . -t ${TOOL}
	docker pull ${TOOL}
