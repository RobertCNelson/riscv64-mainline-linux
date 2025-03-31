#!/bin/echo docker build . -f
# -*- coding: utf-8 -*-

FROM debian:trixie-slim

RUN echo "# log: Setup Proxy" \
    && mkdir -p /etc/apt/apt.conf.d/ \
    && echo "Acquire::http::Proxy \"http://192.168.1.10:3142\";" > /etc/apt/apt.conf.d/00aptproxy

RUN echo "# log: Base Image" \
  && set -x \
  && apt-get update \
  && apt-get dist-upgrade -y

RUN echo "# log: Setup system" \
  && set -x \
  && apt-get install -y \
    bc  \
    bison \
    build-essential \
    cpio  \
    flex  \
    gcc-aarch64-linux-gnu	\
    gcc-arm-linux-gnueabihf	\
    gcc-riscv64-linux-gnu	\
    gettext \
    git \
    libc6-dev	\
    libc6-dev-arm64-cross	\
    libc6-dev-armhf-cross	\
    libc6-dev-riscv64-cross	\
    libmpc-dev  \
    libncurses-dev  \
    libssl-dev  \
    lsb-release \
    lz4 \
    man-db  \
    pkg-config  \
    u-boot-tools  \
    zstd  \
    && sync
  
ENV project riscv64-mainline-linux
ENV workdir /usr/local/opt/${project}/src/${project}
ADD . ${workdir}
WORKDIR ${workdir}

RUN echo "# log: Building ${project}" \
  && set -x \
  && sh -x ./build_deb.sh \ 
  && find deploy/ \
  && sync
