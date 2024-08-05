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

# Add the cron job
(crontab -l 2>/dev/null; echo "0 3 * * * $PROJECT_PATH/scripts/update_containers.sh >> $PROJECT_PATH/logs/update_containers.log 2>&1") | crontab -

# Start/restart the cron service
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo systemctl restart cron
elif [[ "$OSTYPE" == "darwin"* ]]; then
  sudo launchctl unload /System/Library/LaunchDaemons/com.apple.periodic-daily.plist
  sudo launchctl load /System/Library/LaunchDaemons/com.apple.periodic-daily.plist
else
  echo "Please manually restart your cron service."
fi