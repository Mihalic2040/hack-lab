#!/bin/bash


docker stop hack

# Build the Docker image
docker build -t hack-app .

# Run the Docker container with port mapping and other options
docker run -v ./work:/home/main/Desktop/work -p 6080:6080 -p 5999:5999 --name hack --rm -d hack-app

# Provide instructions to access the application
echo "Docker container is running. You can access the application at http://localhost:6080"

