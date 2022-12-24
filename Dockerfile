FROM ubuntu:jammy
ARG USER=build
ARG HOME=/home/$USER

SHELL ["/bin/bash", "-o", "pipefail", "-e", "-u", "-x", "-c"]
ENV DEBIAN_FRONTEND noninteractive
ENV BASH_ENV ~/.bashrc

RUN apt update
RUN apt install -y curl sudo --no-install-recommends

RUN useradd -m -s /bin/bash $USER
RUN echo "$USER ALL=NOPASSWD: ALL" >> /etc/sudoers

USER $USER

RUN echo insecure >> ~/.curlrc && \
  echo location >> ~/.curlrc

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

ARG NVM_DIR=$HOME/.nvm
ARG NODE_VERSION

RUN set +x && \
  source $NVM_DIR/nvm.sh && \
  set -x && \
  nvm install $NODE_VERSION && \
  npm i -g npm@latest yarn@latest

COPY --chown=$USER . $HOME/libxmljs
WORKDIR $HOME/libxmljs
RUN yarn global add @mapbox/node-pre-gyp node-gyp
RUN yarn install --frozen-lockfile
RUN node-pre-gyp build package --build-from-source --fallback-to-build
