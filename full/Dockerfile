FROM rholbrook/datascience:pytorch

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
        'r-essentials' \
        'r-rgl' \
        'r-rjava' \
        'r-rweka' \
        'r-gmp' \
        'r-mlr' \
        'r-lightgbm' \
        'r-rstan' \
        'r-shiny' \
        'r-tidyverse' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# PyPI and CRAN Libraries
RUN pip install xgboost && \
    pip install lightgbm && \
    pip install catboost && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# TODO User libraries
# ADD python_packages.txt
# RUN pip install -r python_packages.txt
# ADD install.R
# RUN Rscript install.R

# ADD .Rprofile
# ADD .Renviron

USER root

# Setup X forwarding
RUN apt-get update
RUN apt-get install -qqy x11-apps

# Some useful utilities
RUN apt-get install less rsync

# Fix PATH weirdness  
RUN ln -s /opt/conda/bin/* /usr/local/bin/

# fix for devtools::github bug caused by conda
RUN ln -s /bin/tar /bin/gtar

USER $NB_UID
