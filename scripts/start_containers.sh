#!/bin/bash
set -e

echo "[ApplicationStart] 🚀 Starting Docker containers..."
cd /home/ubuntu/payroll

# 1. Load image variables
if [ -f "image_vars.env" ]; then
    set -a
    source image_vars.env
    set +a
else
    echo "❌ image_vars.env not found!"
    exit 1
fi

# 2. Validate required variables
if [[ -z "$DOCKER_IMAGE" || -z "$IMAGE_TAG" ]]; then
    echo "❌ DOCKER_IMAGE or IMAGE_TAG is missing"
    exit 1
fi


echo "✅ Using app image: ${DOCKER_IMAGE}:${IMAGE_TAG}"

# 3. Always pull latest images before starting
echo "[ApplicationStart] 🔄 Pulling latest images..."
docker-compose --env-file image_vars.env pull

# 4. Start containers with new images
echo "[ApplicationStart] 🚀 Launching containers..."
docker-compose --env-file image_vars.env up -d --force-recreate

# Remove all images of the repo except the one currently running
CURRENT_IMAGE="${DOCKER_IMAGE}:${IMAGE_TAG}"

for IMG in $(docker images "$DOCKER_IMAGE" --format "{{.Repository}}:{{.Tag}}"); do
  if [ "$IMG" != "$CURRENT_IMAGE" ]; then
    echo "[Cleanup] Removing old image: $IMG"
    docker rmi -f "$IMG" || true
  fi
done


echo "[ApplicationStart] ✅ Done. Containers are up and running."
