FROM ubuntu:jammy
ARG NODE_VERSION

SHELL [ "/bin/bash", "-c" ]

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y curl --no-install-recommends
RUN echo insecure >> ~/.curlrc && \
  echo location >> ~/.curlrc

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
RUN echo export NVM_DIR="$HOME/.nvm" >> ~/.bashrc && \
  echo '[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc && \
  echo '[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.bashrc
RUN echo $PATH && echo $NVM_DIR
# RUN nvm install $NODE_VERSION

# COPY . /libxmljs
# WORKDIR /libxmljs
# RUN npm i -g yarn@latest
# RUN yarn global add @mapbox/node-pre-gyp node-gyp
# RUN yarn install --frozen-lockfile
# RUN node-pre-gyp build package --build-from-source --fallback-to-build
