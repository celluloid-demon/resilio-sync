#!/bin/bash

# Exit on error
set -e

# Declare vars
BUILD="./build"
LIBRARY="./lib"

# Initialize script
init() {

	# Source library file
	if [ -e "$LIBRARY" ]; then

		source "$LIBRARY"

	else

		echo "\'$LIBRARY\' file not found, terminating."
		exit 1

	fi

	# Set default docker command to look for based on host system

	OS_TYPE="$(get_os_type)"

	[ "$OS_TYPE" == "LINUX" ]		&& DOCKER_CMD="docker"
	[ "$OS_TYPE" == "MACOS" ]		&& echo "macOS not supported (because I don't have a mac to test on), terminating." && exit 1
	[ "$OS_TYPE" == "WSL" ]			&& DOCKER_CMD="/mnt/c/Program\ Files/Docker/Docker/Docker\ Desktop.exe"
	[ "$OS_TYPE" == "WINDOWS" ]		&& echo "Unsupported runtime (please run from WSL instead), terminating." && exit 1
	[ "$OS_TYPE" == "UNKNOWN_OS" ]	&& echo "Unknown OS type ('uname -s' output: $(uname -s)), terminating." && exit 1

	# Create build directory if it doesn't already exist
	mkdir -p "./build"

}

# Main logic
main() {

	init

	# WSL: Start Docker Desktop for Windows engine if there is no PID under the
	# process name of 'docker'
	if [ "$OS_TYPE" == "WSL" ] && ! pidof docker > /dev/null; then

		echo "Starting docker..."

		eval "$DOCKER_CMD"

		wait_for_process docker

	fi

	# Start docker service in interactive mode
	docker compose up

}

main
