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
	openjdk-21-jdk \
    lsb-release software-properties-common gnupg \
    && rm -rf /var/lib/apt/lists/*

RUN wget 'https://apt.llvm.org/llvm.sh' -O /tmp/llvm.sh > /dev/null \
    && chmod +x /tmp/llvm.sh \
    && sudo /tmp/llvm.sh 21 > /dev/null \
    && sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-21 100 \
	&& sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-21 100 \
	&& sudo update-alternatives --set clang /usr/bin/clang-21 \
	&& sudo update-alternatives --set clang++ /usr/bin/clang++-21

RUN sed -i -e '8d' /usr/riscv64-linux-gnu/include/gnu/stubs.h
