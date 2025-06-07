#!/bin/bash

# Vikey Inference Docker run script
# Author: direkturcrypto
# Usage: bash docker-run.sh [api_key]

# Set default values
PORT=11434
API_KEY="your_default_api_key_here"

# Check if API key is provided as argument
if [ ! -z "$1" ]; then
  API_KEY="$1"
fi

# Allow user to input API key if not provided and default is used
if [ "$API_KEY" = "your_default_api_key_here" ]; then
  read -p "Enter your Vikey API key (or press Enter to continue without one): " USER_API_KEY
  if [ ! -z "$USER_API_KEY" ]; then
    API_KEY="$USER_API_KEY"
  fi
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
  echo "Docker is not installed. Please install Docker first."
  exit 1
fi

# Check if image exists, build if not
if [[ "$(docker images -q vikey-inference 2> /dev/null)" == "" ]]; then
  echo "Building Docker image..."
  docker build -t vikey-inference \
    --build-arg VIKEY_API_KEY="$API_KEY" \
    --build-arg NODE_PORT="$PORT" .
fi

# Run container
echo "Starting Vikey Inference container..."
docker run -d \
  --name vikey-inference \
  -p "$PORT:$PORT" \
  -e VIKEY_API_KEY="$API_KEY" \
  -e NODE_PORT="$PORT" \
  --restart unless-stopped \
  vikey-inference

if [ $? -eq 0 ]; then
  echo "Vikey Inference is now running on http://localhost:$PORT"
  echo "To stop the container: docker stop vikey-inference"
  echo "To remove the container: docker rm vikey-inference"
fi 