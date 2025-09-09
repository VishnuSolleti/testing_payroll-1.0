##!/bin/bash
## Pulls images and starts containers using docker-compose
#set -euo pipefail
#
#APP_DIR="/home/ubuntu/tarafirst_backend"
#ENV_FILE="$APP_DIR/image_tag.txt"
#
#echo "========== STARTING CONTAINERS =========="
#cd "$APP_DIR" || { echo "App directory not found: $APP_DIR"; exit 1; }
#
#if [ ! -f "$ENV_FILE" ]; then
#    echo "Env file not found: $ENV_FILE"
#    exit 1
#fi
#
## Pull latest versioned images
#echo "Pulling Docker images..."
#docker-compose --env-file "$ENV_FILE" pull
#
## Start containers in detached mode
#echo "Starting containers..."
#docker-compose --env-file "$ENV_FILE" up -d
#
## Show running containers
##echo "Currently running containers:"
##docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"
#
#echo "Containers started successfully."
#!/bin/bash
# Pulls images and starts containers using docker-compose without a .env file
#!/bin/bash
# Pulls images and starts containers using docker-compose
set -euo pipefail

APP_DIR="/home/ubuntu/tarafirst_backend"
ENV_FILE="$APP_DIR/image_tag.txt"

echo "========== STARTING CONTAINERS =========="
cd "$APP_DIR" || { echo "App directory not found: $APP_DIR"; exit 1; }

if [ ! -f "$ENV_FILE" ]; then
    echo "Env file not found: $ENV_FILE"
    exit 1
fi

# Show which images will be used
echo "Using images from $ENV_FILE:"
cat "$ENV_FILE"

# Pull the latest versioned images from Docker Hub
echo "Pulling Docker images..."
docker-compose --env-file "$ENV_FILE" pull

# Start containers in detached mode
echo "Starting containers..."
docker-compose --env-file "$ENV_FILE" up -d

# Show running containers
echo "Currently running containers:"
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"

echo "Containers started successfully."
