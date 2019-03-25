
# Load environment variables from .customenv
if [ -f /root/.customenv ]; then
	source /root/.customenv
fi

alias help="/usr/local/bin/help"
help
