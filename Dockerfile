FROM ubuntu:24.04

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
    make \
    build-essential \
    git \
    python3 \
    python-is-python3 \
    curl \
    libreadline-dev \
    gh \
    sudo \
    wget \
    cmake \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i -e '8d' /usr/riscv64-linux-gnu/include/gnu/stubs.h
