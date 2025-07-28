#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Building Docker image..."
GIT_COMMIT=$(git rev-parse --short HEAD)
IMAGE="aarti1704/myapp:$GIT_COMMIT"

docker build -t $IMAGE .
docker push $IMAGE

echo "✅ Pushed Docker image: $IMAGE"
