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
    make \
    build-essential \
    git \
    python3 \
    python-is-python3 \
    curl \
    tar \
    gh \
    && rm -rf /var/lib/apt/lists/*

# 构建时下载并解压
# --mount=type=secret,id=GH_TOKEN 会将 secret 挂载到 /run/secrets/GH_TOKEN
RUN --mount=type=secret,id=GH_TOKEN \
    export GITHUB_TOKEN=$(cat /run/secrets/GH_TOKEN) && \
    TAG="2025-11-24" && \
    ASSET_NAME=$(gh release view $TAG --repo YosysHQ/oss-cad-suite-build --json assets --jq '.assets[] | select(.name | contains("linux-x64")) | .name') && \
    gh release download $TAG --repo YosysHQ/oss-cad-suite-build --pattern "$ASSET_NAME" && \
    tar xf $ASSET_NAME -C /opt && \
    rm $ASSET_NAME

# 设置环境变量，确保容器运行时能找到 bin
ENV PATH="/opt/oss-cad-suite/bin:${PATH}"

RUN sed -i -e '8d' /usr/riscv64-linux-gnu/include/gnu/stubs.h
