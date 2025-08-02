#!/bin/bash

SRC_DIR="/path/to/backup"                   # תיקיית גיבוי שבה נמצא הארכיון
TGZ="joomla_files_backup.tar.gz"            # שם ארכיון קבצי האתר
DB="/path/to/joomla_db_backup.sql"          # קובץ SQL לשחזור

MYSQL_CONTAINER="mysql-container"
MYSQL_ROOT_PASSWORD="my-secret-pw"          # סיסמת root של MySQL
DB_NAME="joomla"

echo "Restoring Joomla files to volume 'joomla_data'..."
docker volume create joomla_data >/dev/null

docker run --rm -v joomla_data:/data -v "${SRC_DIR}":/backup \
  busybox sh -c "rm -rf /data/* && tar xzf /backup/${TGZ} -C /data"

echo "Files restored."

echo "Restoring MySQL database '${DB_NAME}'..."
cat "${DB}" | docker exec -i ${MYSQL_CONTAINER} sh -c "mysql -uroot -p${MYSQL_ROOT_PASSWORD} ${DB_NAME}"

echo "Database restored."

echo "▶ Restarting Joomla container..."
docker restart joomla-container >/dev/null || true

echo "Done. Open http://localhost:8080"
