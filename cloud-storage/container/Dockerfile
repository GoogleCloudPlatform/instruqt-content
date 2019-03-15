# container with a few programming environments,
# so that folks can play with the cloud storage API.
FROM ubuntu:xenial

# install curl and other dependencies.
RUN apt-get update && \
    apt-get install -y curl software-properties-common \
    emacs vim nano imagemagick build-essential git lynx

# install node.js
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash
RUN apt-get update && \
    apt-get install -y nodejs
# install go
RUN add-apt-repository ppa:gophers/archive && \
    apt-get update && \
    apt-get install -y golang-go

# install google cloud SDK.
RUN mkdir -p /usr/local/lib/
RUN mkdir -p /root/.config/gcloud/
RUN curl https://sdk.cloud.google.com | bash
RUN mv /root/google-cloud-sdk /usr/local/lib/

# install node bins used on machine.
RUN mkdir -p /usr/local/lib/node_modules && \
    cd /usr/local/lib/node_modules && \
    npm i uuid@3.3.2 && \
    ln -s /usr/local/lib/node_modules/.bin/uuid /usr/local/bin/uuid

# install dependencies for challenges.
RUN mkdir /root/node_modules
RUN cd /root; npm i @google-cloud/storage

# install tiv image viewer
RUN git clone https://github.com/stefanhaustein/TerminalImageViewer.git && \
    cd TerminalImageViewer/src/main/cpp && make && make install

# cleanup libraries used during building.
RUN apt-get remove -y git build-essential
