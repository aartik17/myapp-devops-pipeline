#!/usr/bin/env bash
set -euo pipefail

echo "🧹 Cleaning Docker environment..."
docker image prune -f
docker container prune -f
docker network prune -f
echo "✅ Cleanup complete."
