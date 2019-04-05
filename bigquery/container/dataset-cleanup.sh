#!/bin/bash

# Lists all existing datasets in the project and deletes it if older than a threshold
millis_per_minute=$((60 * 1000))
deletion_threshold_millis=$((30 * $millis_per_minute))
now_epoch_millis=$(($(date +%s) * 1000))
all_datasets=( $(bq ls --format=prettyjson --project_id=instruqt-shadow --dataset_id='' | jq --raw-output '.[].datasetReference.datasetId') )
delete_queue=()

for dataset in "${all_datasets[@]}"
do
  creation_time=$(bq show --format=prettyjson --project_id=instruqt-shadow --dataset_id="$dataset" | jq --raw-output '.creationTime')
  creation_age=$(($now_epoch_millis - $creation_time))
  if [[ "$creation_age" -gt "$deletion_threshold_millis" ]]
  then
    bq rm -f -d -r "$dataset"
  fi
done
