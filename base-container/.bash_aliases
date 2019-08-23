# Create the alias for "help"
alias help="/usr/local/bin/help"

# Override alias with a display message on how to exit
alias exit="echo \"To exit the game press Ctrl+Alt+Del\""

# Alias "gcloud" to "gcloud --format=yaml"
alias gcloud="gcloud --format=yaml"

# Load environment variables from .customenv
if [ -f /root/.customenv ]; then
    source /root/.customenv
fi

# Set python to utf-8, which is required for translations
export PYTHONIOENCODING=utf-8

# Load environment variables specified in config.yml
source /etc/profile.d/instruqt-env.sh

# Generate translated environment variables and save them in .translationsenv
if [ ! -s /root/.translationsenv ] && [ -f /root/shell-translations.csv ]; then
    /usr/local/bin/csvtoenv /root/shell-translations.csv >> /root/.translationsenv
fi

# Load translations from .translationsenv
if [ -f /root/.translationsenv ]; then
    source /root/.translationsenv
fi

# The Instruqt background scripts load ".bashrc", so we check $INSTRUQT_GOTTY_SHELL
# to ensure this block is only executed within a challenge.
if [[ -v INSTRUQT_GOTTY_SHELL ]]; then
    # Execute custom bash by creating /root/.customrc in your container or
    # echoing from "setup-shell"
    if [ -f /root/.customrc ]; then
        source /root/.customrc
    fi
    # Display help text
    help

    # Set bash prompt help env vars
    export PROMPT_COMMAND=
    export PROMPT_DEFAULT="$PS1"

    # Hack to print PROMPT_HELP every time except after running "answer"
    trap 'if [ "$BASH_COMMAND" == "answer" ]; then export PS1="$PROMPT_DEFAULT"; else export PS1="$PROMPT_HELP\n$PROMPT_DEFAULT"; fi' DEBUG
fi
