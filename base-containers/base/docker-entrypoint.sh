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

        # Load all credentials of the FIRST project into gcloud
        TMP_FILE=/root/.config/gcloud/default_credentials.json
        SERVICE_ACCOUNT_KEY="INSTRUQT_GCP_PROJECT_${PROJECTS[0]}_SERVICE_ACCOUNT_KEY"
        base64 -d <(echo "${!SERVICE_ACCOUNT_KEY}") > "$TMP_FILE"
        gcloud auth activate-service-account --key-file="$TMP_FILE"

        PROJECT_ID_VAR="INSTRUQT_GCP_PROJECT_${PROJECTS[0]}_PROJECT_ID"

        # Configure project
        gcloud config set project "${!PROJECT_ID_VAR}"

        # Activate application default credentials
        echo "export GOOGLE_APPLICATION_CREDENTIALS=/root/.config/gcloud/default_credentials.json" >> /etc/profile.d/google-adc.sh
        echo "export GOOGLE_CLOUD_PROJECT=${!PROJECT_ID_VAR}" >> /etc/profile.d/google-adc.sh

        # Activate service account for first project
        SERVICE_ACCOUNT_EMAIL="INSTRUQT_GCP_PROJECT_${PROJECTS[0]}_SERVICE_ACCOUNT_EMAIL"
        gcloud config set account "${!SERVICE_ACCOUNT_EMAIL}"

        
    fi
}

gcloud_init  