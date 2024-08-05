#!/bin/bash

# Load the project path from the configuration file
CONFIG_FILE="$(dirname "$0")/../config/project_path.conf"

# Ensure the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Configuration file not found: $CONFIG_FILE"
  exit 1
fi

# Read the project path from the configuration file
PROJECT_PATH=$(grep PROJECT_PATH "$CONFIG_FILE" | cut -d '=' -f2 | tr -d ' ')

# Ensure the project path is not empty
if [ -z "$PROJECT_PATH" ]; then
  echo "Project path is not set in the configuration file."
  exit 1
fi

# Change to the directory where the docker-compose.yml file is located
cd "$PROJECT_PATH" || { echo "Failed to change directory to $PROJECT_PATH"; exit 1; }

# Pull the latest images
docker-compose pull

# Recreate and restart the containers with the latest images
docker-compose up -d