#!/bin/bash

# Variables
SOURCE_DIR="/path/to/source"  # Directory to back up
BACKUP_DIR="/path/to/backup"  # Local backup directory
REMOTE_SERVER="user@remote-server.com:/path/to/remote/backup"
LOG_FILE="backup_log.txt"
DATE=$(date +%Y-%m-%d)

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR/$DATE"

# Perform local backup
rsync -avz "$SOURCE_DIR" "$BACKUP_DIR/$DATE" &>> "$LOG_FILE"
if [ $? -eq 0 ]; then
    echo "Local backup successful on $DATE" | tee -a "$LOG_FILE"
else
    echo "Local backup failed on $DATE" | tee -a "$LOG_FILE"
fi

# Perform remote backup
rsync -avz "$SOURCE_DIR" "$REMOTE_SERVER" &>> "$LOG_FILE"
if [ $? -eq 0 ]; then
    echo "Remote backup successful on $DATE" | tee -a "$LOG_FILE"
else
    echo "Remote backup failed on $DATE" | tee -a "$LOG_FILE"
fi
