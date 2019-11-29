FROM rholbrook/datascience:pytorch

USER root

# Install X11 and improve the shell
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -qqy --no-install-recommends \
        x11-apps \
        less \
        rsync \
        tmux && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

# Conda Libraries
# For Python
RUN conda install --quiet --yes \
        'flake8' \
        'pyjanitor' \
        'flask-sqlalchemy' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# For R
RUN conda install --quiet --yes \
        'r-drake' \
        'r-future' \
        'r-future.apply' \
        'r-gmp' \
        'r-lightgbm' \
        'r-mlr' \
        'r-rgl' \
        'r-rjava' \
        'r-rstan' \
        'r-rweka' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# PyPI and CRAN Libraries
RUN pip install xgboost && \
    pip install lightgbm && \
    pip install catboost && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# ADD .Rprofile
# ADD .Renviron

USER root

# Fix PATH weirdness
RUN ln -s /opt/conda/bin/* /usr/local/bin/

# fix for devtools::github bug caused by conda
RUN ln -s /bin/tar /bin/gtar

USER $NB_UID
