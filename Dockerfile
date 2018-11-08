FROM nvidia/cuda:9.0-devel-ubuntu16.04
LABEL maintainer "Sharedcloud <admin@sharedcloud.io>"

ENV CUDNN_VERSION 7.2.1.38
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

RUN apt-get update && apt-get install -y --no-install-recommends \
            libcudnn7=$CUDNN_VERSION-1+cuda9.2 \
            libcudnn7-dev=$CUDNN_VERSION-1+cuda9.2 && \
    apt-mark hold libcudnn7 && \
    rm -rf /var/lib/apt/lists/*

RUN \
  apt-get update && \
  apt-get install -y python python-dev curl

RUN curl https://bootstrap.pypa.io/get-pip.py | python
RUN pip install tensorflow-gpu==1.10.1 jupyter

WORKDIR /data

CMD /bin/bash && [ ! $CODE ] && jupyter notebook --ip=0.0.0.0 --port=8000 --allow-root --NotebookApp.token='' || python -c "$CODE"
