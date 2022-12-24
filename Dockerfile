FROM ubuntu:jammy
ARG NODE_VERSION

SHELL [ "/bin/bash", "-o", "pipefail", "-c" ]
ENV DEBIAN_FRONTEND noninteractive
ENV BASH_ENV ~/.bashrc

RUN apt update
RUN apt install -y curl --no-install-recommends
RUN echo insecure >> ~/.curlrc && \
  echo location >> ~/.curlrc

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
RUN bash -c '. ~/.bashrc && nvm install $NODE_VERSION'

# COPY . /libxmljs
# WORKDIR /libxmljs
# RUN npm i -g yarn@latest
# RUN yarn global add @mapbox/node-pre-gyp node-gyp
# RUN yarn install --frozen-lockfile
# RUN node-pre-gyp build package --build-from-source --fallback-to-build
