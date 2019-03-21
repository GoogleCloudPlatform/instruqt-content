# base instruqt client image
FROM gcr.io/instruqt/gcp-project-client

# Authorize gcloud for the Instruqt Shadow project
ADD  svc.json svc.json
RUN  gcloud auth activate-service-account --key-file=svc.json && rm svc.json

# Copy over "answer" script
COPY ./bin/answer /usr/local/bin/answer

# Copy over challenge assets
COPY ./files /root/files
