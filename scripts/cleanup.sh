#!/bin/bash

# Remove containers if they exist
docker rm -f mysql-container 2>/dev/null
docker rm -f joomla-container 2>/dev/null

# Remove volumes (only if you want to delete all unused volumes)
docker volume prune -f

# Optionally remove backup files if you have a backup folder
rm -rf ./backup

echo "System cleaned successfully."
