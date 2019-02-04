FROM continuumio/miniconda3:4.5.11

RUN apt-get update -y; apt-get upgrade -y
RUN apt-get install -y vim-tiny vim-athena ssh

RUN useradd -m user01

USER user01
WORKDIR /home/user01

WORKDIR /home/user01/

RUN conda create -c conda-forge -n r-env r-essentials r-shiny
RUN echo "alias l='ls -lah'" >> ~/.bashrc
RUN echo "source activate r-env" >> ~/.bashrc

ENV CONDA_EXE /opt/conda/bin/conda
ENV CONDA_PREFIX /home/user01/.conda/envs/r-env
ENV CONDA_PYTHON_EXE /opt/conda/bin/python
ENV CONDA_PROMPT_MODIFIER (r-env)
ENV CONDA_DEFAULT_ENV r-env
ENV PATH /home/user01/.conda/envs/r-env/bin:/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY install_packages.R ./install_packages.R
RUN bash -c ./install_packages.R

COPY set_some_redis_values.R ./set_some_redis_values.R
