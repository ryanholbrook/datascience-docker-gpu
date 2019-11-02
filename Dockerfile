ARG BASE_CONTAINER=jupyter/datascience-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Ryan Holbrook <ryanholbrook@mathformachines.com>"

USER $NB_UID

# *********************Kaggle *************************************************
RUN conda install --quiet --yes \
        'kaggle'
        && \
        conda clean --all -f -y && \
        fix-permissions $CONDA_DIR && \
        fix-permissions /home/$NB_USER

# Should prompt here for credentials

# *********************Extra R Libraries ***************************************
RUN conda install --quiet --yes \
        'r-essentials'
        'r-import'
        'r-rgl'
        'r-rjava'
        'r-rweka'
        'r-gmp'
        'r-mlr'
        'r-topicmodels'
        'r-xgboost'
        'r-lightgbm'
        'r-catboost'
        'r-naivebayes'
        && \
        conda clean --all -f -y && \
        fix-permissions $CONDA_DIR && \
        fix-permissions /home/$NB_USER

# *********************Extra Python Libraries ***************************************
RUN conda install --quiet --yes \
        'pyjanitor'
        'flask-sqlalchemy'
        && \
        conda clean --all -f -y && \
        fix-permissions $CONDA_DIR && \
        fix-permissions /home/$NB_USER

# *********************Python Deep learning libraries ***************************
# Pytorch
RUN conda install --quiet --yes \
    'pytorch=1.0.*' 'torchvision=0.2.*' -c pytorch && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Tensorflow
# Keras
RUN conda install --quiet --yes \
    'tensorflow-gpu=1.12.*'\
    'keras-gpu=2.2.*' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN conda install --quiet --yes \
    'gnupg'\
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER root

RUN ln -s /opt/conda/bin/* /usr/local/bin/


USER $NB_UID
