ARG BASE_CONTAINER=rholbrook/minimal-gpu-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Ryan Holbrook <ryanholbrook@mathformachines.com>"

##### jupyter/scipy-notebook #####

USER root

# ffmpeg for matplotlib anim
RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

# R packages
RUN conda install --quiet --yes \
        -c conda-forge -c defaults -c gpytorch -c nvidia \
        -c pytorch -c pyviz -c r -c rapidsai \
        ##### Python #####
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
        'panel' \
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
        'xlrd' && \
    conda clean --all -f -y && \
    # Activate ipywidgets extension in the environment that runs the notebook server
    jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
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

# Install facets which does not have a pip or conda package at the moment
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

USER $NB_UID

## Additional Pytorch libraries
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

## Tensorflow
RUN pip install --no-cache-dir \
        tensorflow-gpu==2.0.0 \
        tensorflow-probability==0.8 \
        keras==2.3.1 && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
