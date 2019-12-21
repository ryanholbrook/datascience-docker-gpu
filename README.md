<!-- [![Docker Pulls](https://img.shields.io/docker/pulls/rholbrook/datascience)](https://hub.docker.com/repository/docker/rholbrook/datascience) -->
<!-- [![Docker Stars](https://img.shields.io/docker/stars/rholbrook/datascience)](https://hub.docker.com/repository/docker/rholbrook/datascience) -->

# GPU-Enabled Docker Images

Docker images built off of [`jupyter/minimal-notebook`](https://github.com/jupyter/docker-stacks/tree/master/datascience-notebook) to include GPU support.

Please see the [GitHub repository](https://github.com/ryanholbrook/datascience-docker-gpu) for issues, pull requests, etc.

### Requirements

See [here](https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(Native-GPU-Support)).

<!-- ### Quickstart -->
<!-- Clone the repository. -->
<!-- ``` -->
<!-- git clone https://github.com/ryanholbrook/datascience-docker-gpu.git -->
<!-- ``` -->

<!-- Download the image from Docker Hub and launch a Jupyter Notebook session with your (host) directory `/home/yourname/project/` mounted inside the container. -->
<!-- ``` -->
<!-- cd datascience-docker-gpu/full/ -->
<!-- ./datasci.sh --project /home/yourname/project/ -->
<!-- ``` -->

<!-- **WARNING:** Only data in your `project` directory will be saved after the container exits. If you have data elsewhere and you quit the container, it is gone forever. *(You can also mount persistant storage with `--volume` as usual with `docker`.)* -->

## Contents
There are four images in this repository:
  * `rholbrook/minimal-gpu-notebook` Everything in `jupyter/minimal-notebook` with [CUDA 10.0](https://developer.nvidia.com/cuda-zone) development libraries.
  * `rholbrook/python-gpu-notebook` Everything in `jupyter/scipy-notebook` with, in addition, [Pytorch](https://pytorch.org/) and a number of its extension libraries: [Ignite](https://pytorch.org/ignite/), [fast.ai](https://www.fast.ai/), [Lightning](https://github.com/williamFalcon/pytorch-lightning), [skorch](https://github.com/skorch-dev/skorch), [Ax](https://ax.dev/), [GPyTorch](https://github.com/cornellius-gp/gpytorch), [Pyro](http://pyro.ai/), [Flair](https://github.com/zalandoresearch/flair), [PyTorch Geometric](https://github.com/rusty1s/pytorch_geometric), and [Captum](https://captum.ai/). Also includes all the [RAPIDS](https://docs.rapids.ai/api) libraries.
  * `rholbrook/r-gpu-notebook` Everything in `jupyter/r-notebook` with also [Tensorflow](https://www.tensorflow.org/), [Keras](https://keras.io/), and [Greta](https://greta-stats.org/).
  * `rholbrook/datascience-gpu-notebook` Everything in both `rholbrook/python-gpu-notebook` and `rholbrook/r-gpu-notebook`.
  
The intention is for someone to be able to have a complete development environment for data science and machine learning with a minimum of fuss.

<!--   * [![Download Size](https://images.microbadger.com/badges/image/rholbrook/datascience:cuda-only.svg)](https://hub.docker.com/repository/docker/rholbrook/datascience/tags) `:cuda-only` -->
<!--   * [![Download Size](https://images.microbadger.com/badges/image/rholbrook/datascience:cuda-only.svg)](https://hub.docker.com/repository/docker/rholbrook/datascience/tags) `:pytorch`  -->
<!--   * [![Download Size](https://images.microbadger.com/badges/image/rholbrook/datascience:full.svg)](https://hub.docker.com/repository/docker/rholbrook/datascience/tags) `:full` -->

<!-- ## Usage Examples -->

<!-- Test the installation: -->
<!-- ``` -->
<!-- docker run --rm --gpus all rholbrook/datascience:cuda-only nvidia-smi -->
<!-- ``` -->

<!-- Open an IPython session: -->
<!-- ``` -->
<!-- docker run --rm -it --gpus all rholbrook/datascience:pytorch ipython -->
<!-- ``` -->

<!-- Start a Jupyter notebook server: -->
<!-- ``` -->
<!-- docker run --rm --gpus all rholbrook/datascience:full -->
<!-- ``` -->

<!-- In the `full` directory there is a script `start-shell.sh`. Running it will enter a `bash` shell with container options `-it --rm --gpus all` and X-forwarding enabled. Alternatively, specify a command to run instead of `bash`. You can also use of the usual `docker` [options](https://docs.docker.com/engine/reference/run/) or the [options](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html) from the original Jupyter images. See the script for more details. -->
