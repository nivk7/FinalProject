#!/bin/bash

# מחיקת קונטיינרים
docker rm -f db_container
docker rm -f app_container

# מחיקת volume במידת הצורך
docker volume prune -f

# מחיקת קבצי גיבוי
rm -rf ./backup

# הודעה למשתמש
echo "המערכת נוקתה בהצלחה."
