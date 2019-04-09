# container with a few programming environments,
# so that folks can play with the cloud storage API.
FROM ubuntu:xenial

# install curl and other dependencies.
RUN apt-get update && \
    apt-get install -y curl software-properties-common \
    emacs vim nano imagemagick build-essential git

# install node.js
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash
RUN apt-get update && \
    apt-get install -y nodejs
# install go
RUN add-apt-repository ppa:gophers/archive && \
    apt-get update && \
    apt-get install -y golang-1.10-go

#install pip
RUN apt-get install -y python3-pip
RUN pip3 install --upgrade google-cloud-storage

# install google cloud SDK.
RUN mkdir -p /usr/local/lib/
RUN mkdir -p /root/.config/gcloud/
RUN curl https://sdk.cloud.google.com | bash
RUN mv /root/google-cloud-sdk /usr/local/lib/

# install node bins used on machine.
RUN mkdir -p /usr/local/lib/node_modules && \
    cd /usr/local/lib/node_modules && \
    npm i uuid@3.3.2 json@9.0.6 terminal-quiz@1.2.0 && \
    ln -s /usr/local/lib/node_modules/.bin/uuid /usr/local/bin/uuid && \
    ln -s /usr/local/lib/node_modules/.bin/json /usr/local/bin/json && \
    ln -s /usr/local/lib/node_modules/.bin/terminal-quiz /usr/local/bin/terminal-quiz

# install dependencies for challenges.
RUN mkdir -p /root/node/node_modules
RUN cd /root/node; npm i @google-cloud/storage

# install tiv image viewer
RUN git clone https://github.com/stefanhaustein/TerminalImageViewer.git && \
    cd TerminalImageViewer/src/main/cpp && make && make install

# cleanup libraries used during building.
RUN apt-get remove -y build-essential

COPY ./buddy.png /usr/local/lib/buddy.png

# ensure google cloud is available.
ENV GOPATH /usr/local/lib
RUN ln -sf /usr/lib/go-1.10/bin/go /usr/local/bin/go
RUN go get -u cloud.google.com/go/storage
RUN go get -u google.golang.org/api/iterator
