ARG BASE_CONTAINER=rholbrook/minimal-gpu-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Ryan Holbrook <ryanholbrook@mathformachines.com>"

########## Root Installs ##########

USER root
  
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    'ffmpeg' \
    'fonts-dejavu' \
    'unixodbc' \
    'unixodbc-dev' \
    'gfortran' \
    'gcc' \
    && \
    rm -rf /var/lib/apt/lists/* && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER


USER root
  
# Julia dependencies
# install Julia packages in /opt/julia instead of $HOME
ENV JULIA_DEPOT_PATH=/opt/julia
ENV JULIA_PKGDIR=/opt/julia
ENV JULIA_VERSION=1.2.0

RUN mkdir /opt/julia-${JULIA_VERSION} && \
    cd /tmp && \
    wget -q https://julialang-s3.julialang.org/bin/linux/x64/`echo ${JULIA_VERSION} | cut -d. -f 1,2`/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    echo "926ced5dec5d726ed0d2919e849ff084a320882fb67ab048385849f9483afc47 *julia-${JULIA_VERSION}-linux-x86_64.tar.gz" | sha256sum -c - && \
    tar xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz -C /opt/julia-${JULIA_VERSION} --strip-components=1 && \
    rm /tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz
RUN ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia

# Show Julia where conda libraries are \
RUN mkdir /etc/julia && \
    echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /etc/julia/juliarc.jl && \
    # Create JULIA_PKGDIR \
    mkdir $JULIA_PKGDIR && \
    chown $NB_USER $JULIA_PKGDIR && \
    fix-permissions $JULIA_PKGDIR


########## Conda ##########

USER $NB_UID

RUN conda install --quiet --yes \
    -c conda-forge \
    -c defaults \
    -c gpytorch \
    -c nvidia \
    -c pytorch \
    -c pyviz \
    -c rapidsai \
    -c r \
    'beautifulsoup4' \
    'bokeh' \
    'cloudpickle' \
    'cython' \
    'dask' \
    'dill' \
    'gpytorch' \
    'h5py' \
    'hdf5' \
    'ignite' \
    'ipywidgets' \
    'matplotlib' \
    'numba' \
    'numexpr' \
    'numpy' \
    'pandas' \
    'patsy' \
    'protobuf' \
    'psycopg2' \
    'pytorch' \
    'rapids=0.10' \
    'scikit-image' \
    'scikit-learn' \
    'scipy' \
    'seaborn' \
    'sqlalchemy' \
    'statsmodels' \
    'sympy' \
    'vincent' \
    'unixodbc' \
    'xlrd' \
    'r-base>=3.5' \
    'r-arrow' \
    'r-covr' \
    'r-curl' \
    'r-data.table' \
    'r-devtools' \
    'r-docopt' \
    'r-drake' \
    'r-e1071' \
    'r-formatr' \
    'r-fst' \
    'r-future' \
    'r-future.apply' \
    'r-gdtools' \
    'r-glmnet' \
    'r-glue' \
    'r-gmp' \
    'r-here' \
    'r-hms' \
    'r-htmltools' \
    'r-httr' \
    'r-irkernel' \
    'r-lintr' \
    'r-littler' \
    'r-mass' \
    'r-mlbench' \
    'r-randomforest' \
    'r-rcpparmadillo' \
    'r-reticulate' \
    'r-rgl' \
    'r-rio' \
    'r-rjava' \
    'r-rmarkdown' \
    'r-rodbc' \
    'r-rpart' \
    'r-rsqlite' \
    'r-rstan' \
    'r-rweka' \
    'r-servr' \
    'r-shiny' \
    'r-sf' \
    'r-svglite' \
    'r-testthat' \
    'r-tidyverse' \
    'r-units' \
    'r-validate' \
    'r-zeallot' \
    'r-zoo' \
    'texinfo' \
    'unixodbc' \
    && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER


########## Setup Python ##########

USER $NB_USER

## Activate ipywidgets extension in the environment that runs the notebook server
RUN jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    # Also activate ipywidgets extension for JupyterLab
    # Check this URL for most recent compatibilities
    # https://github.com/jupyter-widgets/ipywidgets/tree/master/packages/jupyterlab-manager
    jupyter labextension install @jupyter-widgets/jupyterlab-manager@^1.0.1 --no-build && \
    jupyter labextension install jupyterlab_bokeh@1.0.0 --no-build && \
    jupyter lab build --dev-build=False && \
    npm cache clean --force && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

## Install facets which does not have a pip or conda package at the moment
RUN cd /tmp && \
    git clone https://github.com/PAIR-code/facets.git && \
    cd facets && \
    jupyter nbextension install facets-dist/ --sys-prefix && \
    cd && \
    rm -rf /tmp/facets && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

## Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME /home/$NB_USER/.cache/
RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions /home/$NB_USER


########## Pip ##########

USER $NB_USER
  
RUN pip install --no-cache-dir \
    'ax-platform' \
    'captum' \
    'torch-geometric' \
    'skorch' \
    'tiny-tokenizer' \
    'fastai' \
    'pytorch-lightning' \
    'pyro-ppl' \
    'flair' \
    'tensorflow-gpu==2.0.0' \
    'tensorflow-probability==0.8' \
    'keras==2.3.1' \
    && \
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
RUN ln -s $R_LIB_PATH/littler/bin/r /usr/local/bin/r && \
    ln -s $R_LIB_PATH/littler/examples/install.r /usr/local/bin/install.r && \
    ln -s $R_LIB_PATH/littler/examples/install2.r /usr/local/bin/install2.r && \
    ln -s $R_LIB_PATH/littler/examples/installGithub.r /usr/local/bin/installGithub.r && \
    rm -rf /tmp/* && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER $NB_USER
RUN install2.r -l $R_LIB_PATH -r $CRAN \
    'renv' \
    'tensorflow' \
    'keras' \
    'greta' \
    && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER root

RUN ln -s /opt/conda/bin/* /usr/local/bin/


########## Pkg ##########



USER $NB_USER
