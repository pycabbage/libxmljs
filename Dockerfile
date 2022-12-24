FROM ubuntu:jammy
ARG USER=build
ARG HOME=/home/$USER

SHELL ["/bin/bash", "-o", "pipefail", "-e", "-u", "-c"]
ENV DEBIAN_FRONTEND noninteractive
ENV BASH_ENV ~/.bashrc

RUN apt update
RUN echo y | unminimize
RUN apt install -y curl sudo python3 build-essential --no-install-recommends

RUN useradd -m -s /bin/bash $USER
RUN echo "$USER ALL=NOPASSWD: ALL" >> /etc/sudoers

USER $USER

RUN echo insecure >> ~/.curlrc && \
  echo location >> ~/.curlrc

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

ARG NVM_DIR=$HOME/.nvm
ARG NODE_VERSION

RUN source $NVM_DIR/nvm.sh && \
  nvm install $NODE_VERSION && \
  npm i -g npm@latest yarn@latest
# ENV PATH $PATH:$(npm -g bin):$($(npm -g bin)/yarn global bin)

COPY --chown=$USER . $HOME/libxmljs
WORKDIR $HOME/libxmljs
RUN source $NVM_DIR/nvm.sh && yarn global add @mapbox/node-pre-gyp node-gyp
RUN source $NVM_DIR/nvm.sh && yarn install --frozen-lockfile
RUN source $NVM_DIR/nvm.sh && node-pre-gyp build package --build-from-source --fallback-to-build
