# base instruqt client image
FROM europe-west1-docker.pkg.dev/instruqt-shadow-resources/library/base:1.2.0

#install pip
RUN apt-get update && \
    apt-get install -y python3-pip && \
    pip3 install --upgrade google-cloud-storage


RUN mkdir /root/python && mkdir /root/node && mkdir /root/go

# install node bins used on machine.
RUN mkdir -p /usr/local/lib/node_modules 
RUN cd /usr/local/lib/node_modules && \
    npm i uuid@3.3.2 json@9.0.6 && \
    ln -s /usr/local/lib/node_modules/.bin/uuid /usr/local/bin/uuid && \
    ln -s /usr/local/lib/node_modules/.bin/json /usr/local/bin/json

# install dependencies for challenges.
RUN mkdir -p /root/node/node_modules
RUN cd /root/node; npm i @google-cloud/storage

# install cloud storage libraries for go.
RUN mkdir -p /root/go && cd /root/go
RUN go mod init arcade.google && \
    go get -u cloud.google.com/go/storage && \
    go get -u google.golang.org/api/iterator

# Copy over container files
RUN mkdir -p /root/.instruqt
COPY ./buddy.png /usr/local/lib/buddy.png
COPY ./translations/*.csv /root/.instruqt
