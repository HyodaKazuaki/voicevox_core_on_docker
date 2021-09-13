FROM nvcr.io/nvidia/cuda:11.1-runtime-ubuntu20.04 as get-voicevox-core

LABEL maintainer="HyodaKazuaki"

ARG VOICEVOX_CORE_VERSION=0.5.2

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        curl \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local

RUN curl -s -OL https://github.com/Hiroshiba/voicevox_core/releases/download/${VOICEVOX_CORE_VERSION}/core.zip && \
    unzip -q core.zip && \
    rm core.zip && \
    mv core voicevox_core


FROM nvcr.io/nvidia/cuda:11.1-runtime-ubuntu20.04 as get-libtorch

LABEL maintainer="HyodaKazuaki"

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        curl \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local

RUN curl -s -OL https://download.pytorch.org/libtorch/cu111/libtorch-cxx11-abi-shared-with-deps-1.9.0%2Bcu111.zip && \
    unzip -q libtorch-cxx11-abi-shared-with-deps-1.9.0%2Bcu111.zip && \
    rm libtorch-cxx11-abi-shared-with-deps-1.9.0%2Bcu111.zip


FROM nvcr.io/nvidia/cuda:11.1-runtime-ubuntu20.04

LABEL maintainer="HyodaKazuaki"

COPY --from=get-voicevox-core /usr/local/voicevox_core /usr/local/voicevox_core
COPY --from=get-libtorch /usr/local/libtorch /usr/local/libtorch

ENV LIBRARY_PATH /usr/local/voicevox_core:${LIBRARY_PATH}
ENV LD_LIBRARY_PATH /usr/local/voicevox_core:${LD_LIBRARY_PATH}
ENV LD_LIBRARY_PATH /usr/local/libtorch/lib:${LD_LIBRARY_PATH}

WORKDIR /
