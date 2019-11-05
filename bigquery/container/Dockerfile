# base instruqt client image
FROM gcr.io/instruqt-shadow/base:1.1.2

# Authorize gcloud for the Instruqt Shadow project
ADD svc.json svc.json
RUN gcloud auth activate-service-account --key-file=svc.json && rm svc.json

# Install uuidgen
RUN apt-get install uuid-runtime

# Copy .customrc to root
COPY .customrc /root/.instruqt/.customrc

# Copy the run-query script
COPY run-query /usr/local/bin/run-query

# Copy the dataset-cleanup script
COPY dataset-cleanup.sh /root/dataset-cleanup.sh

COPY ./translations/*.csv /root/.instruqt/
