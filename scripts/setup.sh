#!/bin/bash

# Check if the Docker network already exists
if ! docker network ls | grep -q ProjectNetwork; then
  echo "Creating Docker network: ProjectNetwork..."
  docker network create --driver bridge ProjectNetwork
else
  echo "Docker network ProjectNetwork already exists."
fi

# Start MySQL container
echo "Starting MySQL container..."
docker run -d \
  --name mysql-container \
  --network ProjectNetwork \
  --restart always \
  -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  -e MYSQL_DATABASE=joomla \
  -e MYSQL_USER=mysql_user \
  -e MYSQL_PASSWORD=mysql_pass \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  mysql

# Start Joomla container
echo "Starting Joomla container..."
docker run -d \
  --name joomla-container \
  --network ProjectNetwork \
  --restart always \
  -e JOOMLA_DB_HOST=db \
  -e JOOMLA_DB_USER=mysql_user \
  -e JOOMLA_DB_PASSWORD=mysql_pass \
  -e JOOMLA_DB_NAME=joomla \
  -p 8080:80 \
  -v joomla_data:/var/www/html \
  joomla

echo "Containers started successfully!"
echo "Visit http://localhost:8080 to access your Joomla site."
