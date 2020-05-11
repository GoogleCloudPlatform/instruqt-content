#!/bin/bash

set -o pipefail

gcloud config set project instruqt-shadow

mv ~/Downloads/Knative\ GKE\ translations\ -\ track-translations.csv knative-gke/track-translations.csv 
mv ~/Downloads/Knative\ GKE\ translations\ -\ shell-translations.csv knative-gke/container/translations/shell-translations.csv \
 && echo $(cd knative-gke/container && gcloud builds submit)
 
./create-track.sh knative-gke/ en
date
