# FROM centos:7
FROM centos/s2i-base-centos7

EXPOSE 8080
EXPOSE 8443

USER root
ENV CONDA_HOME=/opt/conda

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH.
COPY ./s2i/bin/ $STI_SCRIPTS_PATH

RUN /bin/bash -c "\
    yum install -y centos-release-scl; \
    yum -y --setopt=tsflags=nodocs install --enablerepo=centosplus nss_wrapper git; \
    curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh; \
    chmod 755 Miniconda3-latest-Linux-x86_64.sh; \
    ./Miniconda3-latest-Linux-x86_64.sh -b -p $CONDA_HOME; \
    $CONDA_HOME/bin/conda clean -tipsy; \
    chmod -R 777 $CONDA_HOME ~/.conda; \
    rm -f Miniconda3-latest-Linux-x86_64.sh; \
    # find $CONDA_HOME/ -follow -type f -name '*.a' -delete; \
    # find $CONDA_HOME/ -follow -type f -name '*.pyc' -delete; \
    # find $CONDA_HOME/ -follow -type f -name '*.js.map' -delete; \
    rpm -e --nodeps centos-logos; \
    yum -y clean all --enablerepo='*'; \
    rm -rf /var/cache/yum; \
    chown -R 1001:0 ${APP_ROOT}; \
    fix-permissions ${APP_ROOT} -P; \
    rpm-file-permissions \
    "

USER 1001

COPY default-settings/ $APP_ROOT/src/

# ENTRYPOINT bash

# RUN "find $CONDA_HOME/lib/python*/site-packages/bokeh/server/static -follow -type f -name '*.js' ! -name '*.min.js' -delete"