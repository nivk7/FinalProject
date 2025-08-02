#!/bin/bash

# Set these variables before running the script:
# SRC_DIR: path to the directory containing your Joomla backup archive
# TGZ: filename of your Joomla backup archive (e.g. joomla_files_backup.tar.gz)
# DB: path to your MySQL database SQL dump file

echo "Restoring Joomla files to volume 'joomla_data'..."
docker volume create joomla_data >/dev/null

docker run --rm -v joomla_data:/data -v "${SRC_DIR}":/backup \
  busybox sh -c 'rm -rf /data/* && tar xzf "/backup/'"$(basename "${TGZ}")"'" -C /data'

echo "Files restored."

echo "Restoring MySQL database 'joomla'..."
cat "${DB}" | docker exec -i mysql-container sh -c 'mysql -uroot -p"$MYSQL_ROOT_PASSWORD" joomla'

echo "Database restored."

echo "▶ Restarting Joomla container..."
docker restart joomla-container >/dev/null || true

echo "Done. Open http://localhost:8080"
