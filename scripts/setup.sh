#!/bin/bash

# יצירת רשת Docker פנימית
docker network create my_network

# הורדת והרצת הקונטיינרים
docker run -d --name db_container --network my_network my_db_image
docker run -d --name app_container --network my_network my_app_image

# דוגמה להוספת הודעות למשתמש
echo "הקונטיינרים הופעלו בהצלחה."
