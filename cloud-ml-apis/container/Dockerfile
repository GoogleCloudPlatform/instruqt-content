# base instruqt client image
FROM gcr.io/instruqt/gcp-project-client

# Install required dependency to build the image viewer
RUN apt-get update && apt-get install -y build-essential imagemagick

# Install tiv image viewer
RUN git clone https://github.com/stefanhaustein/TerminalImageViewer.git \
	&& cd TerminalImageViewer/src/main/cpp && make && make install

# Remove build deps
RUN apt-get remove -y build-essential

# Authorize gcloud for the Instruqt Shadow project
ADD  svc.json svc.json
RUN  gcloud auth activate-service-account --key-file=svc.json && rm svc.json

# Copy over "answer" script
COPY ./bin/answer /usr/local/bin/answer

# Copy over "help" script
COPY ./bin/help /usr/local/bin/help

# Copy over challenge assets
COPY ./images /home/images
COPY ./quotes /home/quotes
COPY ./videos /home/videos
