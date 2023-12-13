#!/bin/bash

# Exit on error
set -e

# Set working directory (for running from cron)
SCPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCPT_DIR="$(dirname "$SCPT_PATH")"
cd "$SCPT_DIR"

# Declare constants
LIBRARY="./lib"
RESOURCE_DIR="./resources"
SETTINGS="./settings"

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

	# Create settings file if it doesn't already exist
	if [ ! -e "$SETTINGS" ]; then

		echo "\'$SETTINGS\' file not found, creating..."

		cp ${RESOURCE_DIR}/$(basename "$SETTINGS")* ./

		mv "$SETTINGS"* "$SETTINGS"
		
	fi

	# Source settings file
	. "$SETTINGS"

	# Create config directory if it doesn't already exist
	mkdir -p "${CONFIG_DIR:='./config'}"

}

# Main logic
main() {

	init

	# See if main container is already running
	
	# Summary: Exit if container is already running, otherwise begin process to
	# start container.

	# Attempt to get main container id of this docker service
	container_id_main=$(docker ps -aqf "name=$CONTAINER_BASENAME_MAIN")

	# Temporarily disable "exit on error" behavior, attempt to inspect the
	# container and see if it's running
	set +e
	container_status=$(docker inspect -f '{{.State.Status}}' "$container_id_main")
	set -e

	# (relevant values: running, exited)
	if [ "$container_status" == "running" ]; then

		echo "...container already running."
		exit 0

	fi

	# Resume container startup process

	# WSL: Start Docker Desktop for Windows engine if there is no PID under the
	# process name of 'docker'
	if [ "$OS_TYPE" == "WSL" ] && ! pidof docker > /dev/null; then

		echo "Starting docker..."

		eval "$DOCKER_CMD"

		wait_for_process docker

	fi

	docker compose up --detach

}

main
