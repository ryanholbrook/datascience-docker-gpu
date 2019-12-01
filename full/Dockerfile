FROM rholbrook/minimal-gpu-notebook

LABEL maintainer="Ryan Holbrook <ryanholbrook@mathformachines.com>"

##### jupyter/r-notebook #####

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    unixodbc \
    unixodbc-dev \
    r-cran-rodbc \
    gfortran \
    gcc && \
    rm -rf /var/lib/apt/lists/*

# Fix for devtools https://github.com/conda-forge/r-devtools-feedstock/issues/4
RUN ln -s /bin/tar /bin/gtar

USER $NB_UID

# R packages
RUN conda install --quiet --yes \
        -c conda-forge -c defaults -c gpytorch -c nvidia \
        -c pytorch -c pyviz -c r -c rapidsai \
        ##### Python #####
        'beautifulsoup4' \
        'bokeh' \
        'dill' \
        'gpytorch' \
        'h5py' \
        'hdf5' \
        'ignite' \
        'matplotlib' \
        'numba' \
        'numexpr' \
        'numpy' \
        'panel' \
        'patsy' \
        'psycopg2' \
        'pytorch' \
        'rapids=0.10' \
        'scikit-learn' \
        'scipy' \
        'seaborn' \
        'sqlalchemy' \
        'statsmodels' \
        'sympy' \
        ##### R #####
        'r-base' \
        'r-blob' \
        'r-broom' \
        'r-crayon' \
        'r-curl' \
        'r-data.table' \
        'r-dbi' \
        'r-dbplyr' \
        'r-devtools' \
        'r-docopt' \
        'r-dplyr' \
        'r-drake' \
        'r-dtplyr' \
        'r-e1071' \
        'r-forcats' \
        'r-forecast' \
        'r-formatr' \
        'r-fst' \
        'r-future' \
        'r-future.apply' \
        'r-ggplot2' \
        'r-glmnet' \
        'r-glue' \
        'r-gmp' \
        'r-goodpractice' \
        'r-haven' \
        'r-here' \
        'r-hexbin' \
        'r-hms' \
        'r-htmltools' \
        'r-htmlwidgets' \
        'r-httr' \
        'r-irkernel' \
        'r-jsonlite' \
        'r-lattice' \
        'r-lintr' \
        'r-littler' \
        'r-lubridate' \
        'r-magrittr' \
        'r-mass' \
        'r-plyr' \
        'r-purrr' \
        'r-randomforest' \
        'r-readr' \
        'r-readxl' \
        'r-remotes' \
        'r-reprex' \
        'r-reticulate' \
        'r-rgl' \
        'r-rio' \
        'r-rjava' \
        'r-rmarkdown' \
        'r-rodbc' \
        'r-rpart' \
        'r-rsqlite' \
        'r-rstan' \
        'r-rvest' \
        'r-rweka' \
        'r-servr' \
        'r-sessioninfo' \
        'r-shiny' \
        'r-sparklyr' \
        'r-stringr' \
        'r-testthat' \
        'r-tibble' \
        'r-tidyr' \
        'r-tidyverse' \
        'r-validate' \
        'r-workflowr' \
        'r-xml2' \
        'r-zeallot' \
        'r-zoo' \
        'unixodbc' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

########## Tensorflow ##########

RUN pip install --no-cache-dir \
        tensorflow-gpu==2.0.0 \
        tensorflow-probability==0.8 \
        keras==2.3.1 && \
        fix-permissions $CONDA_DIR && \
        fix-permissions /home/$NB_USER

########## Setup R ##########
USER root

RUN echo "\n\
        \nCUDA_HOME=$CUDA_HOME \
        \nCUDA_PATH=$CUDA_PATH \
        \nPATH=$PATH" >> $(R RHOME)/etc/Renviron.site && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

## Scripting
ENV CRAN "https://cloud.r-project.org/"
ENV R_LIB_PATH "/opt/conda/lib/R/library"
## Setup littler for R scripting
RUN ln -s $R_LIB_PATH/littler/bin/r /usr/local/bin/r && \
    ln -s $R_LIB_PATH/littler/examples/install.r /usr/local/bin/install.r && \
    ln -s $R_LIB_PATH/littler/examples/install2.r /usr/local/bin/install2.r && \
    rm -rf /tmp/* && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

## Tensorflow
RUN install2.r -l $R_LIB_PATH -r $CRAN \
        tensorflow \
        keras \
        greta && \
    rm -rf /tmp/* && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

## Other Non-Conda Packages
USER $NB_USER
RUN install2.r -l $R_LIB_PATH -r $CRAN \
        cabinets \
        renv && \
    rm -rf /tmp/* && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

########## Python ##########
## Pytorch
RUN pip install --no-cache-dir \
        ax-platform \
        captum \
        torch-geometric \
        skorch \
        fastai \
        pytorch-lightning \
        pyro-ppl \
        flair && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER root

RUN ln -s /opt/conda/bin/* /usr/local/bin/

USER $NB_USER
