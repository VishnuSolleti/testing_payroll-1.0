  #!/bin/bash
  set -e

  echo "[Stop] 🛑 Stopping and removing old containers..."

  cd /home/ubuntu/payroll

  if [ -f docker-compose.yml ]; then
#    docker compose down --remove-orphans || true
      docker stop payroll_service
  fi

  # Remove dangling (stopped) containers if any
  echo "[Stop] 🧹 Cleaning up stopped containers..."
#  docker container prune -f || true
    docker rm payroll_service
