# voicevox_core_on_docker
[VOICEVOX core library](https://github.com/Hiroshiba/voicevox_core) Docker image

## 種類

### voicevox_core:base-gpu

VOICEVOX コアライブラリとその前提ライブラリがインストールされた基本のDockerイメージです。
CUDAがインストールされており、NVIDIAのGPUを利用した音声合成をすることが可能な環境になっています。
開発するにはソフトウェアが不足している場合があります。
`/usr/local/libtorch`にlibtorchがインストールされています。
`/usr/local/voicevox_core`にVOICEVOX コアライブラリがインストールされています。

#### 使いみち

* 様々な言語での開発・デプロイ向けのベースイメージとして

#### ビルド方法

```bash
docker build -t voicevox_core:base-gpu -f base-gpu.Dockerfile ./
```


### voicevox_core:python-base-gpu

Pythonで実行する上での必要なライブラリがインストールされた基本のDockerイメージです。
CUDAがインストールされており、NVIDIAのGPUを利用した音声合成をすることが可能な環境になっています。
Python 3向けのVOICEVOX コアライブラリパッケージがインストールされています。
開発するにはソフトウェアが不足している場合があります。
`/usr/local/libtorch`にlibtorchがインストールされています。
`/usr/local/voicevox_core`にVOICEVOX コアライブラリがインストールされています。
`/workspace/voicevox_core/example/python`にVOICEVOX コアライブラリのサンプルプログラムがあります。

#### 使いみち

* Python 3での開発・デプロイ向けのベースイメージとして

#### ビルド方法

```bash
# voicevox_core:base-gpuがビルドされている必要があります
docker build -t voicevox_core:python-base-gpu -f python-base-gpu.Dockerfile ./ && 
```


### voicevox_core:example-python-gpu

Pythonのサンプルプログラムを実行するためのDockerイメージです。
CUDAが導入されており、NVIDIAのGPUを利用した音声合成をすることが可能な環境になっています。
イメージだけを実行した場合は、サンプルプログラムのヘルプが表示されます。
`/usr/local/libtorch`にlibtorchがインストールされています。
`/usr/local/voicevox_core`にVOICEVOX コアライブラリがインストールされています。
`/workspace/voicevox_core/example/python`にVOICEVOX コアライブラリのサンプルプログラムがあります。

#### 使いみち

* VOICEVOX コアライブラリのPython 3サンプルプログラムを試すため

#### ビルド方法

```bash
# voicevox_core:base-gpuがビルドされている必要があります
# voicevox_core:python-base-gpuがビルドされている必要があります
docker build -t voicevox_core:example-python-gpu -f example-python-gpu.Dockerfile ./
```

#### 試し方

以下のコマンドを実行する階層の下に`out`ディレクトリが作成され、そこに音声が保存されます。
```bash
# 生成文章と話者の設定
SENTENCE='ドッカーでもこれは本当に実行できているんですか'
SPEAKER_ID=1

# CPUで動作させる場合
docker run --rm -t \
    -v `pwd`/out:/workspace/voicevox_core/example/python/out \
    voicevox_core:example-python-gpu \
    sh -c \
    "python3 run.py --text $SENTENCE --speaker_id $SPEAKER_ID && \
    cp \"$SENTENCE-$SPEAKER_ID.wav\" /workspace/voicevox_core/example/python/out"

# GPUで動作させる場合
docker run --rm -t --gpus all \
    -v `pwd`/out:/workspace/voicevox_core/example/python/out \
    voicevox_core:example-python-gpu \
    sh -c \
    "python3 run.py --use_gpu --text $SENTENCE --speaker_id $SPEAKER_ID && \
    cp \"$SENTENCE-$SPEAKER_ID.wav\" /workspace/voicevox_core/example/python/out"
```


## ライセンス

### Dockerfile

DockerfileはMIT Licenseで提供されています。
詳しくは[LICENSE](LICENSE)をご覧ください。

### Dockerイメージ

各種DockerイメージはVOICEVOX コアライブラリを内包します。
そのため、VOICEVOX コアライブラリの利用規約にも従う必要があります。
Dockerイメージを公開/利用する場合は、両者のライセンス及び利用規約に従ってください。
VOICEVOX コアライブラリの利用規約は各イメージの`/usr/local/voicevox_core/README.txt`をご覧ください。
