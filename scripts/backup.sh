#!/bin/bash

# יצירת תיקיית גיבוי
mkdir -p ./backup

# העתקת קבצים מהרשאה משותפת (volume) לתיקיית הגיבוי
docker cp db_container:/var/lib/mysql ./backup

# הודעה למשתמש
echo "הגיבוי הושלם בהצלחה."
