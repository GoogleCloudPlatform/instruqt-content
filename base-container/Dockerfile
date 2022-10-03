# Base image with all Google Cloud tools
FROM google/cloud-sdk:latest

# Install required dependency to build the image viewer
RUN apt-get update && apt-get install -y build-essential \
  imagemagick \
  software-properties-common

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

# Install go
RUN curl -XGET https://dl.google.com/go/go1.19.1.linux-amd64.tar.gz > /usr/local/lib/go.tar.gz && \
  cd /usr/local/lib && tar -xvf go.tar.gz && rm go.tar.gz
ENV GOPATH /usr/local/lib
RUN ln -sf /usr/local/lib/go/bin/go /usr/local/bin/go

# Install zip
RUN apt-get install -y zip 

# Install terminal-quiz
RUN mkdir -p /usr/local/lib/node_modules && \
    cd /usr/local/lib/node_modules && \
    npm i terminal-quiz@1.2.0 && \
    ln -s /usr/local/lib/node_modules/.bin/terminal-quiz /usr/local/bin/terminal-quiz

# Install tiv image viewer
RUN git clone https://github.com/stefanhaustein/TerminalImageViewer.git \
	&& cd TerminalImageViewer/src/main/cpp && make LDLIBS=-lstdc++fs && make install

# Install vim
RUN apt-get install -y vim nano emacs jed

# Configure auto completion
RUN apt-get install bash-completion
RUN echo 'source <(kubectl completion bash)' >> /etc/bash.bashrc

# Set a few sensible defaults
RUN echo "source /usr/lib/google-cloud-sdk/completion.bash.inc" >> /etc/bash.bashrc && \    
    mkdir -p $HOME/.vim/pack/tpope/start && \
    git clone https://tpope.io/vim/sensible.git $HOME/.vim/pack/tpope/start/sensible && \
    vim -u NONE -c "helptags sensible/doc" -c q && \
    mkdir -p $HOME/.vim/colors && \
    curl -sS --fail -L -o $HOME/.vim/colors/basic-dark.vim https://raw.githubusercontent.com/zcodes/vim-colors-basic/master/colors/basic-dark.vim && \
    echo "include /usr/share/nano/*" > $HOME/.nanorc

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

# Copy over shared translation csv
COPY ./translations/shared-translations.csv /root/.instruqt/

# Env for python translations
ENV PYTHONIOENCODING utf-8
ENV LANG C.UTF-8

ENTRYPOINT [ "/opt/instruqt/docker-entrypoint.sh" ]
COPY docker-entrypoint.sh /opt/instruqt/