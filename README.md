# GPU-Enabled Docker Images

Docker images built off of [`jupyter/datascience-notebook`](https://github.com/jupyter/docker-stacks/tree/master/datascience-notebook), which has environments for R, Python, and Julia.

There are three images in this repository:
  * `rholbrook/datascience:cuda-only` with [CUDA 10.1](https://developer.nvidia.com/cuda-zone) development libraries. I've also added a number of common shell programs.
  * `rholbrook/datascience:pytorch` with, in addition, [Pytorch](https://pytorch.org/) and a number of its extension libraries: [Ignite](https://pytorch.org/ignite/), [fast.ai](https://www.fast.ai/), [Lightning](https://github.com/williamFalcon/pytorch-lightning), [skorch](https://github.com/skorch-dev/skorch), [Ax](https://ax.dev/), [GPyTorch](https://github.com/cornellius-gp/gpytorch), [Pyro](http://pyro.ai/), [Flair](https://github.com/zalandoresearch/flair), [PyTorch Geometric](https://github.com/rusty1s/pytorch_geometric), and [Captum](https://captum.ai/)
  * `rholbrook/datascience:full` with, in addition, for Python [XGBoost](https://github.com/dmlc/xgboost), [LightGBM](https://github.com/microsoft/LightGBM), [CatBoost](https://github.com/catboost/catboost), and some [Dash](https://github.com/plotly/dash) libraries for building dashboards; for R a number of common libraries, especially those with external dependencies.

The intention is for someone to be able to have a complete development environment for data science and machine learning with a minimum of fuss.
