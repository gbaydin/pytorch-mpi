FROM ubuntu:18.04

RUN apt-get update && apt-get install -y git
RUN apt-get install -y wget

RUN wget -O ~/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh
ENV PATH /opt/conda/bin:$PATH

RUN mkdir /code
RUN cd /code && git clone -b v0.4.1 https://github.com/pytorch/pytorch.git
