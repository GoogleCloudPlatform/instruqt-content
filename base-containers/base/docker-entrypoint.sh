#!/bin/bash

# Available env vars:
# INSTRUQT_GCP_PROJECTS
# INSTRUQT_GCP_PROJECT_%s_PROJECT_NAME
# INSTRUQT_GCP_PROJECT_%s_PROJECT_ID
# INSTRUQT_GCP_PROJECT_%s_USER_EMAIL
# INSTRUQT_GCP_PROJECT_%s_USER_PASSWORD
# INSTRUQT_GCP_PROJECT_%s_SERVICE_ACCOUNT_EMAIL
# INSTRUQT_GCP_PROJECT_%s_SERVICE_ACCOUNT_KEY

gcloud_init() {
    if [ -n "${INSTRUQT_GCP_PROJECTS}" ]; then
        PROJECTS=("${INSTRUQT_GCP_PROJECTS//,/ }")

        # load all credentials into gcloud
        for PROJECT in "${PROJECTS[@]}"; do
            TMP_FILE=$(mktemp)
            SERVICE_ACCOUNT_KEY="INSTRUQT_GCP_PROJECT_${PROJECT}_SERVICE_ACCOUNT_KEY"
            base64 -d <(echo "${!SERVICE_ACCOUNT_KEY}") > "$TMP_FILE"
            gcloud auth activate-service-account --key-file="$TMP_FILE"
            rm "$TMP_FILE"
        done

        # activate service account for first project
        SERVICE_ACCOUNT_EMAIL="INSTRUQT_GCP_PROJECT_${PROJECTS[0]}_SERVICE_ACCOUNT_EMAIL"
        gcloud config set account "${!SERVICE_ACCOUNT_EMAIL}"

        # configure project
        PROJECT_ID="INSTRUQT_GCP_PROJECT_${PROJECTS[0]}_PROJECT_ID"
        gcloud config set project "${!PROJECT_ID}"
    fi
}

gcloud_init  