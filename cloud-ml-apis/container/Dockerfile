# base instruqt client image
FROM gcr.io/instruqt-shadow/base:1.1.3

# Authorize gcloud for the Instruqt Shadow project
ADD  svc.json svc.json
RUN  gcloud auth activate-service-account --key-file=svc.json && rm svc.json
RUN  gcloud config set project instruqt-shadow

# add "googler" script
RUN cd /tmp && \
   git clone https://github.com/jarun/googler.git /usr/local/lib/googler && \
   make install -C /usr/local/lib/googler

# Copy over challenge assets
COPY ./images /root/images
COPY ./audio /root/audio
COPY ./videos /root/videos
COPY ./text /root/text
COPY ./translations/*.csv /root/.instruqt/
