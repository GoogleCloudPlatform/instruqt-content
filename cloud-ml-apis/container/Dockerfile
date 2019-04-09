# base instruqt client image
FROM gcr.io/instruqt-shadow/base

# Authorize gcloud for the Instruqt Shadow project
ADD  svc.json svc.json
RUN  gcloud auth activate-service-account --key-file=svc.json && rm svc.json

# add "googler" script
RUN cd /tmp && \
   git clone https://github.com/jarun/googler.git /usr/local/lib/googler && \
   make install -C /usr/local/lib/googler

ENV PYTHONIOENCODING utf-8

# Copy over challenge assets
COPY ./images /root/images
COPY ./audio /root/audio
COPY ./videos /root/videos
COPY ./text /root/text
