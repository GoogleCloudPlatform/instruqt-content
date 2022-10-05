# base instruqt client image
FROM europe-west1-docker.pkg.dev/instruqt-shadow-resources/library/base:1.2.0

# add "googler" script
RUN cd /tmp && \
   git clone https://github.com/jarun/googler.git /usr/local/lib/googler && \
   make install -C /usr/local/lib/googler

# Copy over challenge assets
COPY ./images /root/images
COPY ./audio /root/audio
COPY ./videos /root/videos
COPY ./text /root/text
