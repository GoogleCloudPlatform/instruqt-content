gcloud config set project instruqt-shadow
mv ~/Downloads/Cloud\ Run\ Track\ Two\ translations\ -\ track-translations.csv cloud-run-track-two/track-translations.csv && \
mv ~/Downloads/Cloud\ Run\ Track\ Two\ translations\ -\ shell-translations.csv cloud-run-track-two/container/translations/shell-translations.csv
cd cloud-run-track-two/container && gcloud builds submit && cd ../../
./create-track.sh cloud-run-track-two/ en
date
