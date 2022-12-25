ARG ARCH=amd64
FROM $ARCH/ubuntu:latest
ARG USER=build
ARG HOME=/home/$USER

SHELL ["/bin/bash", "-o", "pipefail", "-e", "-u", "-c"]
ENV DEBIAN_FRONTEND noninteractive

RUN apt update
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
  nvm install $NODE_VERSION --latest-npm
RUN source $NVM_DIR/nvm.sh && \
  npm i -g yarn@latest && \
  yarn global add @mapbox/node-pre-gyp node-gyp

COPY --chown=$USER . $HOME/libxmljs

WORKDIR $HOME/libxmljs
RUN rm -fr ./node_modules/
RUN source $NVM_DIR/nvm.sh && yarn install --frozen-lockfile
RUN source $NVM_DIR/nvm.sh && yarn build && yarn dist
RUN ls -lR build/stage/pycabbage/libxmljs/releases/download/
RUN sudo mkdir /dist/ && sudo cp -r build/stage/pycabbage/libxmljs/releases/download/*/*.tar.gz /dist/

USER root
CMD while :; do sleep 3600; done
