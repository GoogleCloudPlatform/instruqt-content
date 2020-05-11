FROM gcr.io/instruqt-shadow/base:1.3.0

# There is an alias in the base image that makes gcloud
# default to yaml output, because that is better to read
# on the smaller (less wide) arcade screens. 
# For this challenge, the default output format suits better.
RUN echo "alias gcloud=gcloud" >> /root/.bash_aliases
COPY ./translations/*.csv /root/.instruqt/
