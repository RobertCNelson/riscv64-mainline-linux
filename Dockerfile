#!/bin/echo docker build . -f
# -*- coding: utf-8 -*-

FROM debian:trixie-slim

RUN echo "# log: Setup system" \
  && set -x \
  && apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y \
    build-essential \
		gcc-aarch64-linux-gnu	\
		gcc-arm-linux-gnueabihf	\
		gcc-riscv64-linux-gnu	\
		libc6-dev	\
		libc6-dev-arm64-cross	\
		libc6-dev-armhf-cross	\
		libc6-dev-riscv64-cross	\
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
