#!/bin/bash

# Exit on error
set -e

# Declare constants
SETTINGS="./settings"

# Main logic
main() {

    echo "Backing up ${SETTINGS}..."

    # Remove settings file if it exists
	if [ -e "$SETTINGS" ]; then

        mv "$SETTINGS" "${SETTINGS}_BAK"
        echo "...moved to ${SETTINGS}_BAK."
		
	fi

    echo "Done."

}

main
