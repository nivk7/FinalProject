#!/bin/bash

# Create backup directory
mkdir -p ./backup

# Copy MySQL data from the container to the backup folder
docker cp mysql-container:/var/lib/mysql ./backup

# Notify the user
echo "Backup completed successfully."
