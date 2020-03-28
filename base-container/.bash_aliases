# Create the alias for "help"
alias help="/usr/local/bin/help"

# Override alias with a display message on how to exit
alias exit="echo \"To exit the game press Ctrl+Alt+Del\""

INSTRUQT_DIR=/root/.instruqt

# Load environment variables from .customenv
if [ -f $INSTRUQT_DIR/.customenv ]; then
    source $INSTRUQT_DIR/.customenv
fi

# Set python to utf-8, which is required for translations
export PYTHONIOENCODING=utf-8

# Load environment variables specified in config.yml
source /etc/profile.d/instruqt-env.sh

# Generate translated environment variables and save them in .translationsenv
if [ ! -s .translationsenv ] && [ -f $INSTRUQT_DIR/shell-translations.csv ]; then
    /usr/local/bin/csvtoenv $INSTRUQT_DIR/shared-translations.csv >> $INSTRUQT_DIR/.translationsenv
    /usr/local/bin/csvtoenv $INSTRUQT_DIR/shell-translations.csv >> $INSTRUQT_DIR/.translationsenv
fi

# Load translations from .translationsenv
if [ -f $INSTRUQT_DIR/.translationsenv ]; then
    source $INSTRUQT_DIR/.translationsenv
fi

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

    # Hack to print PROMPT_HELP every time except after running "answer"
    # Only do this if "$INSTRUQT_DIR/choices.txt" is present
    if [ -f $INSTRUQT_DIR/choices.txt ]; then
        # Set bash prompt help env vars
        export PROMPT_COMMAND=
        export PROMPT_DEFAULT="$PS1"
        trap 'if [ "$BASH_COMMAND" == "answer" ]; then export PS1="$PROMPT_DEFAULT"; else export PS1="$PROMPT_HELP\n$PROMPT_DEFAULT"; fi' DEBUG
    fi
fi
