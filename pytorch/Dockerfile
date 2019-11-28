FROM rholbrook/datascience:cuda-only

RUN conda install --quiet --yes -c pytorch \
        'pytorch' \
        'torchvision' \
        'torchtext' \
        'torchaudio' \
        'ignite' \
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
    pip install captum && \
    pip install torch-geometric && \
    pip install skorch && \
    pip install fastai && \
    pip install pytorch-lightning && \
    pip install pyro-ppl && \
    pip install flair && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
    
