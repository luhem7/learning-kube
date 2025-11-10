#!/bin/bash

# Configuration
IMAGE_NAME="learning-kube-httpd"
IMAGE_TAG="latest"

echo "Building container image..."

# Build the image using Podman
podman build -t ${IMAGE_NAME}:${IMAGE_TAG} .

# Verify the image was created
echo ""
echo "Image built successfully:"
podman images | grep ${IMAGE_NAME}

echo ""
echo "To test the image locally:"
echo "podman run -d --name test-built-image -p 8080:80 ${IMAGE_NAME}:${IMAGE_TAG}"