FROM centos:7 AS builder

USER root
ENV CONDA_HOME=/opt/miniconda
RUN /bin/bash -c "\
    curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh; \
    chmod 755 Miniconda3-latest-Linux-x86_64.sh; \
    ./Miniconda3-latest-Linux-x86_64.sh -b -p $CONDA_HOME; \
    $CONDA_HOME/bin/conda init; \
    chmod -R 777 $CONDA_HOME/envs; \
    rm -f Miniconda3-latest-Linux-x86_64.sh; \
    find $CONDA_HOME/ -follow -type f -name '*.a' -delete; \
    find $CONDA_HOME/ -follow -type f -name '*.pyc' -delete; \
    find $CONDA_HOME/ -follow -type f -name '*.js.map' -delete"

# RUN "find $CONDA_HOME/lib/python*/site-packages/bokeh/server/static -follow -type f -name '*.js' ! -name '*.min.js' -delete"