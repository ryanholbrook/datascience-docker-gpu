FROM rholbrook/datascience:pytorch

# Extra Python Libraries
RUN conda install --quiet --yes \
        'pyjanitor' \
        'flask-sqlalchemy' \
        && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# For making dashboards
RUN pip install dash==1.4.1 && \
    pip install dash-daq==0.2.1 && \
    pip install dash-bootstrap-components

RUN pip install xgboost && \
    pip install lightgbm && \
    pip install catboost

# Extra R Libraries
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
        'r-tidyverse' \
        && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# RUN Rscript /r_packages.R

# TODO Add R config files
# ADD .Rprofile .Renvironment

RUN ln -s /opt/conda/bin/* /usr/local/bin/
