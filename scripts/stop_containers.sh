set -euo pipefail

APP_DIR="/home/ubuntu/tarafirst_backend"
ENV_FILE="$APP_DIR/image_tag.txt"

echo "========== STOPPING CONTAINERS =========="
cd "$APP_DIR" || { echo "App directory not found: $APP_DIR"; exit 1; }

if [ ! -f "$ENV_FILE" ]; then
    echo "Env file not found: $ENV_FILE"
    exit 1
fi

# Show which images will be used
echo "Using images from $ENV_FILE:"
cat "$ENV_FILE"

# Stop containers gracefully
docker-compose --env-file "$ENV_FILE" down || echo "No running containers to stop"

echo "Containers stopped successfully."
