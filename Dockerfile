# tool-chains
FROM alpine
COPY ./riscv /riscv
ENTRYPOINT ["/bin/bash"]