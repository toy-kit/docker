#!/bin/bash
set -e

# Docker image pull script
# Pull from Alibaba Cloud registry and retag as local image
# Usage: ./pull.sh library/golang:1.23-alpine
#        curl -fsSL <url>/pull.sh | bash -s -- library/golang:1.23-alpine

REGISTRY="registry.cn-hangzhou.aliyuncs.com/toy-kit/docker"

IMAGE="${1}"

if [ -z "$IMAGE" ]; then
    echo "Usage: bash pull.sh <image>"
    echo "Example: bash pull.sh library/golang:1.23-alpine"
    echo "         bash pull.sh golang:1.23-alpine"
    exit 1
fi

# Remove library/ prefix if present
IMAGE="${IMAGE#library/}"

# Generate registry tag: replace / with -, then : with .
REGISTRY_TAG="${IMAGE//\//-}"
REGISTRY_TAG="${REGISTRY_TAG/:/.}"

REGISTRY_IMAGE="${REGISTRY}:${REGISTRY_TAG}"

echo "==> Pulling: ${REGISTRY_IMAGE}"
docker pull "${REGISTRY_IMAGE}"

echo "==> Tagging: ${REGISTRY_IMAGE} -> ${IMAGE}"
docker tag "${REGISTRY_IMAGE}" "${IMAGE}"

echo "==> Removing registry image: ${REGISTRY_IMAGE}"
docker rmi "${REGISTRY_IMAGE}"

echo "==> Done: ${IMAGE}"
