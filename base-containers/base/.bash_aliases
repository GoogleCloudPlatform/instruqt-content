#!/bin/bash

# Create the alias for "help"
alias help="/usr/local/bin/help"

# Override alias with a display message on how to exit
alias exit="echo \"To exit the game press Ctrl+Alt+Del\""

# Alias "gcloud" to "gcloud --format=yaml"
# alias gcloud="gcloud --format=yaml"

INSTRUQT_DIR=/root/.instruqt

# Load environment variables from .customenv
if [ -f $INSTRUQT_DIR/.customenv ]; then
    source $INSTRUQT_DIR/.customenv
fi

# Set python to utf-8, which is required for translations
export PYTHONIOENCODING=utf-8

# Load environment variables specified in config.yml
source /etc/profile.d/instruqt-env.sh

# The Instruqt background scripts load ".bashrc", so we check $INSTRUQT_GOTTY_SHELL
# to ensure this block is only executed within a challenge.
if [[ -v INSTRUQT_GOTTY_SHELL ]]; then
    # Execute custom bash by creating $INSTRUQT_DIR/.customrc in your container or
    # echoing from "setup-shell"
    if [ -f $INSTRUQT_DIR/.customrc ]; then
        source $INSTRUQT_DIR/.customrc
    fi
    # Display help text
    help
fi
