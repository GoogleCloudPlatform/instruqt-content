FROM gcr.io/instruqt-shadow/base
RUN mkdir /app
WORKDIR '/app'
RUN apt-get update -y && \
  apt-get -y install google-cloud-sdk-app-engine-go && \
  git clone https://github.com/tpryan/GCPQuest-Companion.git
WORKDIR '/app/GCPQuest-Companion'