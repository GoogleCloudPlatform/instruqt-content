# container with a few programming environments,
# so that folks can play with the cloud storage API.
FROM gcr.io/instruqt-shadow/base:1.1.2

#install pip
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install --upgrade google-cloud-storage

# install node bins used on machine.
RUN mkdir -p /usr/local/lib/node_modules
RUN cd /usr/local/lib/node_modules && \
    npm i uuid@3.3.2 json@9.0.6 terminal-quiz@1.2.0 && \
    ln -s /usr/local/lib/node_modules/.bin/uuid /usr/local/bin/uuid && \
    ln -s /usr/local/lib/node_modules/.bin/json /usr/local/bin/json

# install dependencies for challenges.
RUN mkdir -p /root/node/node_modules
RUN cd /root/node; npm i @google-cloud/storage

RUN mkdir -p /root/.instruqt
COPY ./buddy.png /usr/local/lib/buddy.png
COPY ./translations/*.csv /root/.instruqt

# install cloud storage libraries for go.
RUN go get -u cloud.google.com/go/storage
RUN go get -u google.golang.org/api/iterator
