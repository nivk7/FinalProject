echo "Restoring Joomla files to volume 'joomla-data'..."
docker volume create joomla-data >/dev/null
docker run --rm -v joomla-data:/data -v "${SRC_DIR}":/backup       busybox sh -c 'rm -rf /data/* && tar xzf "/backup/'"$(basename "${TGZ}")"'" -C /data'
echo "Files restored."

echo "Restoring MySQL database 'joomla'..."
cat "${DB}" | docker exec -i mysql sh -c 'mysql -uroot -p"$MYSQL_ROOT_PASSWORD" joomla'
echo "Database restored."

echo "▶ Restarting Joomla container..."
docker restart my-joomla >/dev/null || true
echo " Done. Open http://localhost:8080"
