#!/bin/bash

# Learning Kube - HTTP Server Runner
# This script demonstrates basic Podman container operations

set -e  # Exit on any error

# Configuration
CONTAINER_NAME="learning-kube-httpd"
HOST_PORT="8080"
CONTAINER_PORT="80"
IMAGE="docker.io/library/httpd:latest"

echo "Starting HTTP server container..."

# Stop and remove existing container if it exists
if podman ps -a --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
    echo "Stopping existing container: ${CONTAINER_NAME}"
    podman stop ${CONTAINER_NAME} || true
    echo "Removing existing container: ${CONTAINER_NAME}"
    podman rm ${CONTAINER_NAME}
fi

# Run the container with volume mount to serve our custom index.html
echo "Starting new HTTP server container..."
podman run -d \
    --name ${CONTAINER_NAME} \
    -p ${HOST_PORT}:${CONTAINER_PORT} \
    -v $(pwd):/usr/local/apache2/htdocs/:ro \
    ${IMAGE}

# Check if container is running
if podman ps --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
    echo "Container '${CONTAINER_NAME}' is running!"
    echo "Server accessible at: http://localhost:${HOST_PORT}"
    echo ""
    echo "Useful commands:"
    echo "   podman logs ${CONTAINER_NAME}     # View server logs"
    echo "   podman logs -l                   # View logs (latest container)"
    echo "   podman stop ${CONTAINER_NAME}    # Stop the server"
    echo "   podman stop -l                   # Stop latest container"
    echo "   curl http://localhost:${HOST_PORT}  # Test from command line"
else
    echo "Failed to start container"
    exit 1
fi