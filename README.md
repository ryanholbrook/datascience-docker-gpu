[![Build Status](https://travis-ci.org/ryanholbrook/datascience-docker-gpu.svg?branch=testing)](https://travis-ci.org/ryanholbrook/datascience-docker-gpu)

# GPU-Enabled Docker Images

Docker images built off of [`jupyter/minimal-notebook`](https://github.com/jupyter/docker-stacks/tree/master/minimal-notebook) to include GPU support.

The images in this repository hope to provide development environments for data science and machine learning without the pain of dependency mangement. I have tried to include the most commonly used packages that have long or difficult installations, but you will likely need to install additional packages suitable for your project.

Please see the [GitHub repository](https://github.com/ryanholbrook/datascience-docker-gpu) for issues, pull requests, etc.

### Requirements

You will need an up-to-date version of [Docker](https://docs.docker.com/install/), 
and a modern NVIDIA GPU with an up-to-date driver. See [here](https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(Native-GPU-Support)) for more details.

### Quickstart

Clone the repository.
```
git clone https://github.com/ryanholbrook/datascience-docker-gpu.git
cd datascience-docker-gpu
```

Download the image from Docker Hub and launch a shell session.
```
./start.sh
```

Alternatively, start a Jupyter notebook session.
```
./start.sh notebook
```

Say you have a project on your host machine in the directory `/home/myname/project`. You can mount this directory inside the container's working directory like this:
```
./start.sh --work "/home/myname/project"
```
The default username in the Jupyter images is `jovyan` and the default working directory is `work`. Your project directory will therefore be mounted at `/home/jovyan/work/`.

**WARNING:** Only data in the `/home/jovyan/work` directory will be saved after the container exits. If you have data elsewhere and you quit the container, it is gone forever. *(The script passes on arguments to the `docker` command, so you could also mount persistant storage with `--volume` as usual.)*

## Contents
There are five images in this repository:
  * `rholbrook/minimal-gpu-notebook` Everything in `jupyter/minimal-notebook` with [CUDA 10.0](https://developer.nvidia.com/cuda-zone) development libraries.
  * `rholbrook/python-gpu-notebook` Everything in `jupyter/scipy-notebook` with, in addition, [Pytorch](https://pytorch.org/) and a number of its extension libraries: [Ignite](https://pytorch.org/ignite/), [fast.ai](https://www.fast.ai/), [Lightning](https://github.com/williamFalcon/pytorch-lightning), [skorch](https://github.com/skorch-dev/skorch), [Ax](https://ax.dev/), [GPyTorch](https://github.com/cornellius-gp/gpytorch), [Pyro](http://pyro.ai/), [Flair](https://github.com/zalandoresearch/flair), [PyTorch Geometric](https://github.com/rusty1s/pytorch_geometric), and [Captum](https://captum.ai/). Also includes all the [RAPIDS](https://docs.rapids.ai/api) libraries.
  * `rholbrook/r-gpu-notebook` (Most) everything in `jupyter/r-notebook` with also [Tensorflow](https://www.tensorflow.org/), [Keras](https://keras.io/), and [Greta](https://greta-stats.org/). Also includes some other commonly used packages, especially those with troublesome dependencies.
  * `rholbrook/julia-gpu-notebook` A Julia environment. (In progress.)
  * `rholbrook/datascience-gpu-notebook` Everything in both `rholbrook/python-gpu-notebook` and `rholbrook/r-gpu-notebook`.

## Usage

I recommend using `start.sh` to launch these images. The script automatically provides support for GPUs as well as interaction with the windowing system on the host machine. You can as always launch the container using `docker` directly, though you will need to use `--gpus all` to make your GPU devices visible to the container. See [here](https://github.com/NVIDIA/nvidia-docker) under **Usage** for details.

Use `start.sh` to start a Bash shell in the container, or use `start.sh notebook` to start a Jupyter notebook server. You can use `--work <directory>` to mount a directory on your host machine as your working directory (`/home/jovyan/work`) in the container, and you can use `--dot <filepath>` to mount a file from your host machine into your home directory (`/home/jovyan`) in the container. You can also use [any of the usual arguments](https://docs.docker.com/engine/reference/commandline/cli/) for the Docker command line. See the [Jupyter Docker stacks documentation](https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html) for more on running and customizing these images.

### Example

I usually do something like this:
```
./start.sh --memory 30g --work /home/ryan/project --dot /home/ryan/.gitconfig --dot /home/ryan/.Renviron
```
This *1.* limits the container to 30g of RAM on the host machine, *2.* mounts the directory of the project I want to work on, and *3.* includes my Git and R config files.

------

Please file an Issue if you have any trouble.
