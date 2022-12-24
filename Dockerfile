FROM ubuntu:jammy
ARG NODE_VERSION

SHELL [ "/bin/bash", "-o", "pipefail", "-e", "-u", "-x", "-c" ]
ENV DEBIAN_FRONTEND noninteractive
ENV BASH_ENV ~/.bashrc

RUN apt update
RUN apt install -y curl --no-install-recommends
RUN echo insecure >> ~/.curlrc && \
  echo location >> ~/.curlrc

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

RUN set +x && \
  source $NVM_DIR/nvm.sh && \
  set -x && \
  nvm install $NODE_VERSION && \
  npm i -g npm@latest yarn@latest
ENV NODE_PATH $NVM_DIR/$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH

COPY . /libxmljs
WORKDIR /libxmljs
RUN yarn global add @mapbox/node-pre-gyp node-gyp
RUN yarn install --frozen-lockfile
RUN node-pre-gyp build package --build-from-source --fallback-to-build
