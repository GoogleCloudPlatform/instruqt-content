# base instruqt client image
FROM gcr.io/instruqt/gcp-project-client

# Install required dependency to build the image viewer
RUN apt-get update && apt-get install -y build-essential imagemagick

# Install tiv image viewer
RUN git clone https://github.com/stefanhaustein/TerminalImageViewer.git \
	&& cd TerminalImageViewer/src/main/cpp && make && make install

# Remove build deps
RUN apt-get remove -y build-essential

# Copy over "answer" script
COPY ./bin/answer /usr/local/bin/answer

# Copy over "help" script
COPY ./bin/help /usr/local/bin/help

# Copy over "hint" script
COPY ./bin/hint /usr/local/bin/hint

# Copy over ".bash_aliases"
COPY ./.bash_aliases /root/.bash_aliases
