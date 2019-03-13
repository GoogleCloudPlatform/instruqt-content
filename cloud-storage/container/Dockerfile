# container with a few programming environments,
# so that folks can play with the cloud storage API.
FROM ubuntu:xenial

# install text editors

# install cloud SDK.


# install curl.
RUN apt-get update && \
    apt-get install -y curl software-properties-common
# install node.js
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash
RUN apt-get update && \
    apt-get install -y nodejs
# install go
RUN add-apt-repository ppa:gophers/archive && \
    apt-get update && \
    apt-get install -y golang-go