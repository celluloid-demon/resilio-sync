#!/bin/bash

# Exit on error
set -e

# Force working directory (useful for portability, running from cron, etc)
SCPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCPT_DIR="$(dirname "$SCPT_PATH")"
cd "$SCPT_DIR"

# Declare vars
CONFIG="./config/rslsync.conf"

# Main logic
main() {

	# Check for dependencies (rslsync) and exit on error if missing
	if ! command -v rslsync &> /dev/null; then

		echo "Error: 'rslsync' command not found. Please install rslsync before running this script."
		exit 1

	fi

	if [ -f "$CONFIG" ]; then

		echo "$CONFIG not found (please create with `rslsync --dump-sample-config` and customize), terminating."
		exit 1

	fi

	# Start resilio sync process in configuration mode
	rslsync --config "$CONFIG"

}

main
