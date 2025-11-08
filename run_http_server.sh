#!/bin/bash


set -e  # Exit on any error

# Configuration
CONTAINER_NAME="learning-kube-httpd"
HOST_PORT="8080"
CONTAINER_PORT="80"
IMAGE="docker.io/library/httpd:latest"
SERVER_ROOT="$(pwd)/ca_server/src"

# Function to display success message and commands
show_success() {
    echo "Container '${CONTAINER_NAME}' is running!"
    echo "Server accessible at: http://localhost:${HOST_PORT}"
    echo ""
    echo "Useful commands:"
    echo "   podman logs ${CONTAINER_NAME}     # View server logs"
    echo "   podman stop ${CONTAINER_NAME}    # Stop the server"
    echo "   curl http://localhost:${HOST_PORT}  # Test from command line"
}

echo "Starting HTTP server container..."

# Check if container exists and handle accordingly
if podman ps -a --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
    # Container exists - start it if stopped
    if ! podman ps --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
        echo "Container exists but is stopped. Starting..."
        podman start ${CONTAINER_NAME}
    else
        echo "Container is already running."
    fi
else
    # Container doesn't exist - create and run it
    echo "Creating new HTTP server container..."
    podman run -d \
        --name ${CONTAINER_NAME} \
        -p ${HOST_PORT}:${CONTAINER_PORT} \
        -v ${SERVER_ROOT}:/usr/local/apache2/htdocs/:ro \
        ${IMAGE}
fi

# Show success message
show_success