FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04 AS nvidia
FROM jupyter/datascience-notebook

LABEL maintainer="Ryan Holbrook <ryanholbrook@mathformachines.com>"

USER root

# Cuda support
COPY --from=nvidia /etc/apt/sources.list.d/cuda.list /etc/apt/sources.list.d/
COPY --from=nvidia /etc/apt/sources.list.d/nvidia-ml.list /etc/apt/sources.list.d/
COPY --from=nvidia /etc/apt/trusted.gpg /etc/apt/trusted.gpg.d/cuda.gpg

ENV CUDA_VERSION=10.1.243
ENV CUDA_PKG_VERSION=10-1=$CUDA_VERSION-1
ENV CUDNN_VERSION 7.6.4.38
LABEL com.nvidia.volumes.needed="nvidia_driver"
LABEL com.nvidia.cuda.version="${CUDA_VERSION}"
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH="/usr/local/nvidia/lib64:/usr/local/cuda/lib64:/usr/local/cuda/lib64/stubs"
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV NVIDIA_REQUIRE_CUDA="cuda>=10.1"
RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-cudart-$CUDA_PKG_VERSION \
        cuda-cudart-dev-$CUDA_PKG_VERSION \
        cuda-libraries-$CUDA_PKG_VERSION \
        cuda-libraries-dev-$CUDA_PKG_VERSION \
        cuda-nvml-dev-$CUDA_PKG_VERSION \
        cuda-minimal-build-$CUDA_PKG_VERSION \
        cuda-command-line-tools-$CUDA_PKG_VERSION \
        libcudnn7=$CUDNN_VERSION-1+cuda10.1 \
        libcudnn7-dev=$CUDNN_VERSION-1+cuda10.1 && \
        ln -s /usr/local/cuda-10.1 /usr/local/cuda && \
        ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 && \
        apt-get autoremove -y && \
        apt-get clean
ENV CUDA_HOME=/usr/local/cuda

# Kaggle
RUN conda install --quiet --yes \
        'kaggle' && \
        conda clean --all -f -y && \
        fix-permissions $CONDA_DIR && \
        fix-permissions /home/$NB_USER

# Should prompt here for credentials

# Extra R Libraries
RUN conda install --quiet --yes \
        'r-essentials' \
        'r-import' \
        'r-rgl' \
        'r-rjava' \
        'r-rweka' \
        'r-gmp' \
        'r-mlr' \
        'r-topicmodels' \
        'r-lightgbm' \
        'r-catboost' \
        'r-naivebayes' \
        && \
        conda clean --all -f -y && \
        fix-permissions $CONDA_DIR && \
        fix-permissions /home/$NB_USER

# Extra Python Libraries
RUN conda install --quiet --yes \
        'pyjanitor' \
        'flask-sqlalchemy' \
        && \
        conda clean --all -f -y && \
        fix-permissions $CONDA_DIR && \
        fix-permissions /home/$NB_USER

# Pytorch
RUN conda install --quiet --yes \
        'pytorch=1.3.*' 'torchvision=0.4.*' -c pytorch && \
        conda clean --all -f -y && \
        fix-permissions $CONDA_DIR && \
        fix-permissions /home/$NB_USER

# Tensorflow and Keras
RUN conda install -c anaconda --quiet --yes \
        'keras-gpu' && \
        conda clean --all -f -y && \
        fix-permissions $CONDA_DIR && \
        fix-permissions /home/$NB_USER

RUN conda install --quiet --yes \
        'gnupg' && \
        conda clean --all -f -y && \
        fix-permissions $CONDA_DIR && \
        fix-permissions /home/$NB_USER

# TODO Add R config files
# ADD .Rprofile .Renvironment

RUN ln -s /opt/conda/bin/* /usr/local/bin/

USER $NB_UID
