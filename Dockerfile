#!/bin/echo docker build . -f
# -*- coding: utf-8 -*-

FROM robertcnelson/beagle-devscripts-kernel-debian-13-amd64:latest
#https://openbeagle.org/beagleboard/ci-docker-images

RUN echo "# log: Setup Proxy" \
    && mkdir -p /etc/apt/apt.conf.d/ \
    && echo "Acquire::http::Proxy \"http://192.168.1.10:3142\";" > /etc/apt/apt.conf.d/00aptproxy

RUN echo "# log: Base Image" \
  && set -x \
  && apt-get update \
  && apt-get dist-upgrade -y

#RUN echo "# log: Install Missing Packages" \
#  && set -x \
#  && apt-get install -y \
#    <>  \
#    && sync

RUN echo "# log: Download git bundle" \
    && wget -c https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/clone.bundle
  
ENV project riscv64-mainline-linux
ENV workdir /usr/local/opt/${project}/src/${project}
ADD . ${workdir}
WORKDIR ${workdir}

RUN echo "# log: Building ${project}" \
  && set -x \
  && cp system.sh.sample system.sh \
  && echo "CC=riscv64-linux-gnu-" >> system.sh \
  && ls -lha ../* \
  && sh -x ./build_deb.sh \ 
  && find deploy/ \
  && sync
