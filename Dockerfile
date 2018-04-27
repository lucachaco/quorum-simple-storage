FROM ubuntu

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

RUN set -eu -o pipefail

# install build deps
RUN apt-get install -y software-properties-common

RUN add-apt-repository ppa:ethereum/ethereum

RUN apt-get update

RUN apt-get install -y build-essential unzip libdb-dev libleveldb-dev libsodium-dev zlib1g-dev libtinfo-dev solc sysvbanner wrk

RUN apt install -y curl

# install constellation
RUN curl -L https://github.com/jpmorganchase/constellation/releases/download/v0.3.2/constellation-0.3.2-ubuntu1604.tar.xz -o constellation-0.3.2-ubuntu1604.tar.xz
RUN tar xf constellation-0.3.2-ubuntu1604.tar.xz
RUN cp constellation-0.3.2-ubuntu1604/constellation-node /usr/local/bin

# install go

RUN curl -O https://storage.googleapis.com/golang/go1.9.1.linux-amd64.tar.gz
RUN tar -xvf go1.9.1.linux-amd64.tar.gz
RUN mv go /usr/local
ENV PATH="/usr/local/go/bin:${PATH}"

# install quorum
RUN apt-get install -y git
RUN git clone https://github.com/jpmorganchase/quorum.git
WORKDIR /quorum
RUN git checkout tags/v2.0.1
RUN make all
RUN cp build/bin/geth /usr/local/bin
RUN cp build/bin/bootnode /usr/local/bin
WORKDIR /


# install Porosity
RUN curl -L https://github.com/jpmorganchase/quorum/releases/download/v1.2.0/porosity -o porosity
RUN mv porosity /usr/local/bin && chmod 0755 /usr/local/bin/porosity


##get examples

RUN git clone https://github.com/jpmorganchase/quorum-examples.git


## install tools

RUN apt-get install -y net-tools
run apt-get install -y nano

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 9.0.0

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# confirm node installation
RUN node -v
RUN npm -v

#install truffle

RUN npm install truffle -g

#install app

WORKDIR home
RUN pwd
RUN git clone https://github.com/lucachaco/quorum-simple-storage.git










