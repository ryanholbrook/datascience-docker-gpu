FROM rholbrook/datascience:cuda-only

USER $NB_UID

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

RUN pip install --no-cache-dir \
        ax-platform \
        captum \
        torch-geometric \
        skorch \
        fastai \
        pytorch-lightning \
        pyro-ppl \
        flair \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
    
USER $NB_UID
