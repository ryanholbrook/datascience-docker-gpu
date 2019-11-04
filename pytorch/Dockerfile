FROM rholbrook/datascience:cuda-only

RUN conda install --quiet --yes -c pytorch \
        'pytorch=1.3.*' \
        'torchvision=0.4.*' \
        'torchtext' \
        'torchaudio' \
        'ignite=0.2.*' \
        'captum' \
        && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN conda install --quiet --yes -c gpytorch \
        'gpytorch' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN pip install ax-platform && \
    pip install torch-geometric && \
    pip install skorch && \
    pip install fastai && \
    pip install pyro-ppl && \
    pip install flair
