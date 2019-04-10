# Create the alias for "help"
alias help="/usr/local/bin/help"

# Override alias with a display message on how to exit
alias exit="echo To exit the game press Ctrl+Alt+Del"

# Load environment variables from .customenv
if [ -f /root/.customenv ]; then
    source /root/.customenv
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
fi
