#!/bin/bash

CONFIG_FILE="$(dirname "$0")/../config/project_path.conf"
LOG_FILE="$(dirname "$0")/../logs/update_containers.log"

# Create the logs directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

echo "Starting container update process at $(date)" >> "$LOG_FILE"

# Ensure the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Configuration file not found: $CONFIG_FILE" >> "$LOG_FILE"
  exit 1
fi

# Read the project path from the configuration file
PROJECT_PATH=$(grep PROJECT_PATH "$CONFIG_FILE" | cut -d '=' -f2 | tr -d ' ')
IMAGES_LIST=$(grep IMAGES_LIST "$CONFIG_FILE" | cut -d '=' -f2 | tr -d ' ')
IFS=',' read -ra IMAGES <<< "$IMAGES_LIST"

# Ensure the project path is not empty
if [ -z "$PROJECT_PATH" ]; then
  echo "Project path is not set in the configuration file." >> "$LOG_FILE"
  exit 1
fi

cd "$PROJECT_PATH" || { echo "Failed to change directory to $PROJECT_PATH" >> "$LOG_FILE"; exit 1; }

for IMAGE in "${IMAGES[@]}"; do
  echo "Pulling image $IMAGE at $(date)" >> "$LOG_FILE"
  docker pull "$IMAGE" >> "$LOG_FILE" 2>&1
  if [ $? -ne 0 ]; then
    echo "Failed to pull image $IMAGE at $(date)" >> "$LOG_FILE"
  else
    echo "Successfully pulled image $IMAGE at $(date)" >> "$LOG_FILE"
  fi
done

echo "Stopping and removing containers at $(date)" >> "$LOG_FILE"
docker-compose down >> "$LOG_FILE" 2>&1
if [ $? -ne 0 ]; then
  echo "Failed to stop and remove containers at $(date)" >> "$LOG_FILE"
else
  echo "Successfully stopped and removed containers at $(date)" >> "$LOG_FILE"
fi

echo "Starting containers at $(date)" >> "$LOG_FILE"
docker-compose up -d >> "$LOG_FILE" 2>&1
if [ $? -ne 0 ]; then
  echo "Failed to start containers at $(date)" >> "$LOG_FILE"
else
  echo "Successfully started containers at $(date)" >> "$LOG_FILE"
fi

echo "Container update process completed at $(date)" >> "$LOG_FILE"
