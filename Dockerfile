FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu-24.04 as developer

ENV DOCKER=docker-27.3.1

# install pre-requisites
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean

# install the docker ce cli binary
RUN curl -O https://download.docker.com/linux/static/stable/x86_64/${DOCKER}.tgz && \
    tar xvf ${DOCKER}.tgz && \
    cp docker/docker /usr/bin && \
    rm -r ${DOCKER}.tgz docker

# TODO for testing X11 forwarding only
RUN apt-get update && \
    apt-get install -y x11-apps && \
    apt-get clean

FROM ubuntu as runtime

RUN echo add your runtime things here ...
