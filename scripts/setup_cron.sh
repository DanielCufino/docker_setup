#!/bin/bash

CONFIG_FILE="$(dirname "$0")/../config/project_path.conf"
LOG_FILE="$(dirname "$0")/../logs/setup_cron.log"

# Create the logs directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

# Ensure the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Configuration file not found: $CONFIG_FILE" >> "$LOG_FILE"
  exit 1
fi

# Read the project path from the configuration file
PROJECT_PATH=$(grep PROJECT_PATH "$CONFIG_FILE" | cut -d '=' -f2 | tr -d ' ')

# Ensure the project path is not empty
if [ -z "$PROJECT_PATH" ]; then
  echo "Project path is not set in the configuration file." >> "$LOG_FILE"
  exit 1
fi

# Add the cron job
(crontab -l 2>/dev/null; echo "0 * * * * $PROJECT_PATH/scripts/update_containers.sh >> $PROJECT_PATH/logs/cron.log 2>&1") | crontab -

# Start/restart the cron service
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo systemctl restart cron >> "$LOG_FILE" 2>&1
elif [[ "$OSTYPE" == "darwin"* ]]; then
  sudo launchctl unload /System/Library/LaunchDaemons/com.apple.periodic-daily.plist >> "$LOG_FILE" 2>&1
  sudo launchctl load /System/Library/LaunchDaemons/com.apple.periodic-daily.plist >> "$LOG_FILE" 2>&1
else
  echo "Please manually restart your cron service." >> "$LOG_FILE"
fi

echo "Cron job setup completed at $(date)" >> "$LOG_FILE"
