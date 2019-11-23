[![Docker Pulls](https://img.shields.io/docker/pulls/rholbrook/datascience)](https://hub.docker.com/repository/docker/rholbrook/datascience)
[![Docker Stars](https://img.shields.io/docker/stars/rholbrook/datascience)](https://hub.docker.com/repository/docker/rholbrook/datascience)

# GPU-Enabled Docker Images

Docker images built off of [`jupyter/datascience-notebook`](https://github.com/jupyter/docker-stacks/tree/master/datascience-notebook), which has environments for R, Python, and Julia. Includes GPU support.

Please see the [GitHub repository](https://github.com/ryanholbrook/datascience-docker-gpu) for issues, pull requests, etc.

### Quickstart
Clone the repository.
```
git clone https://github.com/ryanholbrook/datascience-docker-gpu.git
```

Download the image from Docker Hub and launch a Jupyter Notebook session with `/home/yourname/project/` as the working directory.
```
cd datascience-docker-gpu/full/
./datasci.sh --project /home/yourname/project/
```

## Contents
There are three images in this repository:
  * `rholbrook/datascience:cuda-only` with [CUDA 10.0](https://developer.nvidia.com/cuda-zone) development libraries.
  * `rholbrook/datascience:pytorch` with, in addition, [Pytorch](https://pytorch.org/) and a number of its extension libraries: [Ignite](https://pytorch.org/ignite/), [fast.ai](https://www.fast.ai/), [Lightning](https://github.com/williamFalcon/pytorch-lightning), [skorch](https://github.com/skorch-dev/skorch), [Ax](https://ax.dev/), [GPyTorch](https://github.com/cornellius-gp/gpytorch), [Pyro](http://pyro.ai/), [Flair](https://github.com/zalandoresearch/flair), [PyTorch Geometric](https://github.com/rusty1s/pytorch_geometric), and [Captum](https://captum.ai/) <span style = "color:red"> (Captum temporarily removed due to Conda environment issues.) </span>
  * `rholbrook/datascience:full`
 with, in addition, for Python [XGBoost](https://github.com/dmlc/xgboost), [LightGBM](https://github.com/microsoft/LightGBM), [CatBoost](https://github.com/catboost/catboost), and some [Dash](https://github.com/plotly/dash) libraries for building dashboards; for R a number of common libraries, especially those with external dependencies.

The intention is for someone to be able to have a complete development environment for data science and machine learning with a minimum of fuss.

 * **:cuda-only** [![Download Size](https://images.microbadger.com/badges/image/rholbrook/datascience:cuda-only.svg)](https://hub.docker.com/repository/docker/rholbrook/datascience/tags)
  * **:pytorch** [![Download Size](https://images.microbadger.com/badges/image/rholbrook/datascience:cuda-only.svg)](https://hub.docker.com/repository/docker/rholbrook/datascience/tags)
  * **:full**  [![Download Size](https://images.microbadger.com/badges/image/rholbrook/datascience:full.svg)](https://hub.docker.com/repository/docker/rholbrook/datascience/tags)

## Usage Examples

Test the installation:
```
docker run --rm --gpus all rholbrook/datascience:cuda-only nvidia-smi
```

Open an IPython session:
```
docker run --rm -it --gpus all rholbrook/datascience:pytorch ipython
```

Start a Jupyter notebook server:
```
docker run --rm --gpus all rholbrook/datascience:full
```

In the `full` directory there is a script `datasci.sh`. Running it will launch the container as so:
``` 
docker run \
       --name datascience \
       --rm \
       --interactive \
       --tty \
       --gpus all \
       --network=host\
       --env DISPLAY=$DISPLAY \
       --volume $XAUTHORITY:/home/jovyan/.Xauthority \
       $KEYWORD \
       rholbrook/datascience:full \
       start.sh \
       $POSITIONAL
```
       
where `$KEYWORD` and `$POSITIONAL` are options passed to `datasci.sh` in the usual manner of `docker`. This will run the container with X-forwarding in case you want to open X windows on the host machine (for plotting from iPython, for instance).

Say you wanted to start an iPython session and use the directory `/home/ryan/project/` as your project directory for persistent storage. You could do:
```datasci.sh --project /home/ryan/project/ ipython```

This will mount `/home/ryan/project/` to `/home/jovyan/work/` in the container, which is the default storage directory in the Jupyter stacks.
