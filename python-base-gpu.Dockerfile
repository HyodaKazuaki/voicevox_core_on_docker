FROM voicevox_core:base-gpu as get-voicevox-core

LABEL maintainer="HyodaKazuaki"

ARG VOICEVOX_CORE_VERSION=0.5.2

WORKDIR /workspace

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        curl \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -s -OL https://github.com/Hiroshiba/voicevox_core/archive/refs/tags/${VOICEVOX_CORE_VERSION}.zip && \
    unzip ${VOICEVOX_CORE_VERSION}.zip && \
    mv voicevox_core-${VOICEVOX_CORE_VERSION} voicevox_core

FROM voicevox_core:base-gpu

LABEL maintainer="HyodaKazuaki"

ARG VOICEVOX_CORE_VERSION=0.5.2

WORKDIR /workspace

COPY --from=get-voicevox-core /workspace/voicevox_core /workspace/voicevox_core

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        libsndfile1 \
        cmake \
        build-essential \
        git \
        python3 \
        python3-dev \
        python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace/voicevox_core/example/python

RUN cp /usr/local/voicevox_core/core.h ./ && \
    pip install -U cython 'numpy<1.21' && \
    pip install .

WORKDIR /workspace
