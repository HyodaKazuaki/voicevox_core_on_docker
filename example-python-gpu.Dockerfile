FROM voicevox_core:python-base-gpu

LABEL maintainer="HyodaKazuaki"

WORKDIR /workspace/voicevox_core/example/python

RUN pip install -U -r requirements.txt && \
    python3 -c "import pyopenjtalk; pyopenjtalk._lazy_init()" && \
    sed -i -e "s/core.initialize(\".\/\", use_gpu)/core.initialize(\"\/usr\/local\/voicevox_core\/\", use_gpu)/" run.py

CMD [ "/usr/bin/python3", "run.py", "--help" ]
