#!/bin/bash
# Copyright 2019 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
