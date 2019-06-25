# base instruqt client image
FROM gcr.io/instruqt/gcp-project-client

# Install required dependency to build the image viewer
RUN apt-get update && apt-get install -y build-essential imagemagick

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash
RUN apt-get update && \
    apt-get install -y nodejs

# Install terminal-quiz
RUN mkdir -p /usr/local/lib/node_modules && \
    cd /usr/local/lib/node_modules && \
    npm i terminal-quiz@1.2.0 && \
    ln -s /usr/local/lib/node_modules/.bin/terminal-quiz /usr/local/bin/terminal-quiz

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

# Copy over "csvtoenv" script
COPY ./bin/csvtoenv /usr/local/bin/csvtoenv
