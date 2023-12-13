#!/bin/bash

# Exit on error
set -e

# Declare constants
SETTINGS="./settings"

# Initialize script
init() {

	# Create settings file if it doesn't already exist
	if [ ! -e "$SETTINGS" ]; then

		echo "'$SETTINGS' file not found, creating..."

		cp ${RESOURCE_DIR}/$(basename "$SETTINGS")* ./

		mv "$SETTINGS"* "$SETTINGS"
		
	fi

	# Source settings file
	. "$SETTINGS"

}

# Main logic
main() {

    init

    docker compose down

}

main
