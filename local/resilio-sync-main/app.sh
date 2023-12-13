#!/bin/bash

# Exit on error
set -e

# Declare vars
CONFIG="./config/rslsync.conf"

# Main logic
main() {

	# Check for dependencies (rslsync) and exit on error if missing
	if ! command -v rslsync &> /dev/null; then

		echo "Error: 'rslsync' command not found. Please install rslsync before running this script."
		exit 1

	fi

	if [ ! -f "$CONFIG" ]; then

		echo "$CONFIG not found (please create with 'rslsync --dump-sample-config' and customize), terminating."
		exit 1

	fi

	# Start resilio sync process in configuration mode
	rslsync --config "$CONFIG"

	# Since rslsync gets forked in the background, we must sleep indefinitely to
	# prevent the shell script process from terminating (and thus spinning down
	# the container).
	sleep infinity

}

main
