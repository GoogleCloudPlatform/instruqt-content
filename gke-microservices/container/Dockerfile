FROM gcr.io/instruqt/gcp-project-client
ADD svc.json svc.json
RUN gcloud auth activate-service-account --key-file=svc.json && rm svc.json
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.11.0/bin/linux/amd64/kubectl && \
  chmod +x ./kubectl && \
  mv ./kubectl /usr/bin/kubectl