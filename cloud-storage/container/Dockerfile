# container with a few programming environments,
# so that folks can play with the cloud storage API.
FROM ubuntu:xenial

# install curl and other dependencies.
RUN apt-get update && \
    apt-get install -y curl software-properties-common \
    emacs vim nano graphicsmagick

# install node.js
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash
RUN apt-get update && \
    apt-get install -y nodejs
# install go
RUN add-apt-repository ppa:gophers/archive && \
    apt-get update && \
    apt-get install -y golang-go

# install google cloud SDK.
RUN curl https://sdk.cloud.google.com | bash

# install node bins used on machine.
RUN mkdir -p /usr/local/lib/node_modules && \
    cd /usr/local/lib/node_modules && \
    npm i image-to-ascii-cli@1.0.10 uuid@3.3.2 && \
    ln -s /usr/local/lib/node_modules/.bin/image-to-ascii /usr/local/bin/image-to-ascii && \
    ln -s /usr/local/lib/node_modules/.bin/uuid /usr/local/bin/uuid
