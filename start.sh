#!/bin/bash

# Build the Docker image
docker build -t hack-app .

# Run the Docker container with port mapping and other options
docker run -d \
  -p 6080:6080 \
  --nawme novnc-container \
  --rm \
  hack-app

# Provide instructions to access the application
echo "Docker container is running. You can access the application at http://localhost:6080"

