FROM ubuntu:18.04
# Atilim Gunes Baydin, University of Oxford
# November 2018
LABEL maintainer="Atilim Gunes Baydin <gunes@robots.ox.ac.uk>"

RUN apt-get update && apt-get install -y git wget build-essential
RUN mkdir /code

RUN wget -O /code/openmpi.tar.gz  https://www.open-mpi.org/software/ompi/v3.0/downloads/openmpi-3.0.0.tar.gz
RUN cd /code && tar xvzf openmpi.tar.gz && rm /code/openmpi.tar.gz
RUN cd /code/openmpi-3.0.0 && ./configure --prefix=/home/.openmpi && make all install
ENV PATH="$PATH:/home/$USER/.openmpi/bin"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/$USER/.openmpi/lib/"

RUN wget -O ~/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh
ENV PATH /opt/conda/bin:$PATH

ENV CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"
ENV NO_CUDA=1

RUN conda install numpy pyyaml mkl mkl-include setuptools cmake cffi typing
RUN conda install -c mingfeima mkldnn

RUN cd /code && git clone -b v0.4.1 --recursive https://github.com/pytorch/pytorch
RUN cd /code/pytorch && python setup.py install
