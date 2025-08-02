# Joomla + MySQL via Docker (Afeka vLab Setup)

This project allows you to run a Joomla website with MySQL using Docker containers. It's designed for vLab environments where data isn't persistent.

Group Members: Niv Kalbo, Ori Israelov, Tamir Eliasy

What we did
Created a Docker Network
Ran the command:

docker network create ProjectNetwork
to set up an internal network between the containers.

Created a docker-compose.yml File
Defined Joomla and MySQL containers with network, volumes, and environment variables for passwords.

Started the Website and Created Users
Ran the site via Docker, accessed the admin panel, and created an admin user as well as other users.

Added Content to the Site
Wrote articles and pages inside the Joomla interface.

Backed Up the MySQL Database
Performed backups of the database using Docker commands and mysqldump.

Wrote Management Scripts
Developed scripts for managing the project:

setup.sh — setup and start environment

backup.sh — create backups

restore.sh — restore from backups

cleanup.sh — clean up environment (stop containers, remove volumes and files)

Challenges Faced
Backup and Restore Issues:
We encountered difficulties restoring the database backup due to permission errors and the need for correct MySQL user privileges.

Ensuring the backup file (my-joomla.backup.sql.gz) was correctly decompressed and imported inside the MySQL container required precise command syntax and passing the correct credentials.

Additionally, syncing Joomla files with the database backup to maintain site consistency was a challenge, solved by carefully managing Docker volumes and mount points.

Troubleshooting Docker container networking and volume mounting was necessary to allow Joomla to connect correctly to the MySQL database after restore.

---
Project Requirements
Set up the basic environment using Docker
We were asked to install and configure the core components of the project using Docker containers.

Configure Joomla
We needed to perform the initial configuration of the Joomla CMS inside the containerized environment.

Run Joomla and add initial content
We were instructed to start the Joomla service and add basic content to the website (e.g. articles).

Back up the website and database
We were required to create backups of the site files and the MySQL database to preserve the project state.

Restore the database from backup
As part of the testing process, we had to verify that the database backup could be successfully restored.

Write shell scripts for automation
We were asked to write Bash scripts to automate setup, backup, restore, and cleanup processes.

Save the project on GitHub
The final step was to upload all project files, including scripts and the Docker configuration, to a Git repository.
---

## 🚀 How to Run

1. Clone the repo:
```bash
mkdir -p ~/projects && cd ~/projects
git clone https://github.com/nivk7/FinalProject-.git
cd FinalProject-
```

2. Make scripts executable and fix line endings:
```bash
chmod +x *.sh
sed -i 's/\r$//' *.sh
```

3. Start the site:
```bash
./run.sh
```

Open: [http://localhost:8080/administrator](http://localhost:8080)

login:  

```
Admin Username:  demoadmin

Admin Password: secretpassword

Email:  admin@gmail.com

Host: mysql-containter

Username: mysql_user

Password: mysql_pass

Database Name: joomla
```
---

## 💾 After Editing Site (e.g., new articles)

1. set your account for git uploading:
```bash
git config --global user.email "(YourEmail)@gmail.com"
git config --global user.name "(YourUsername)"
```
2. Backup:
```bash
./backup.sh
```
or: 
```bash
mkdir -p backups
cp ~/backups/joomla-db-*.sql        backups/joomla-db-backup.sql
cp ~/backups/joomla-files-*.tar.gz  backups/joomla-files-backup.tar.gz
```
3. Push to GitHub:
```bash
git add .
git commit -m "Update backup"
git push
```
---

## 🔁 For Next Login

Just re-clone the repo and run:
```bash
./run.sh
```

That's it. Your site and DB will be restored automatically.
