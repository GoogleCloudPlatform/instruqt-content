FROM gcr.io/instruqt-shadow/base:1.3.0

RUN apt-get install kubectl python3-pip -y
RUN python3 -m pip install pyyaml

# There is an alias in the base image that makes gcloud
# default to yaml output, because that is better to read
# on the smaller (less wide) arcade screens. 
# For this challenge, the default output format suits better.
RUN echo "alias gcloud=gcloud" >> /root/.bash_aliases

COPY ./translations/*.csv /root/.instruqt/
