FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-ttf-dev \
    g++-riscv64-linux-gnu \
    llvm \
    llvm-dev \
    scons \
    libunwind-dev \
    liblzma-dev \
    && rm -rf /var/lib/apt/lists/*

# Remove the __riscv_float_abi_soft stub definition that causes build errors
# when cross-compiling for RISC-V targets that use a different float ABI.
RUN sed -i -e '8d' /usr/riscv64-linux-gnu/include/gnu/stubs.h
