gcloud config set project instruqt-shadow
mv ~/Downloads/Cloud\ Run\ Track\ One\ translations\ -\ track-translations.csv cloud-run-track-one/track-translations.csv && \
mv ~/Downloads/Cloud\ Run\ Track\ One\ translations\ -\ shell-translations.csv cloud-run-track-one/container/translations/shell-translations.csv
cd cloud-run-track-one/container && gcloud builds submit && cd ../../
./create-track.sh cloud-run-track-one/ en
date
