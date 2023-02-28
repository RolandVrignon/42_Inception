#!/bin/bash

# Start MariaDB server
echo "Starting Mariadb server"
/etc/init.d/mysql start

# Wait for the server to start
while ! mysqladmin ping -hlocalhost --silent; do
	echo "wait"
  	sleep 1
done

echo "Mariadb server started"

sleep 30000000

# Check if database exists
if mysql -e "use ${MYSQL_DATABASE}" &> /dev/null; then
  echo "Database ${MYSQL_DATABASE} already exists, skipping creation."
else
  # Create database
  echo "Creating database ${MYSQL_DATABASE} ..."
  mysql -e "CREATE DATABASE ${MYSQL_DATABASE};"
fi

# Check if root user exists
if [[ $(mysql -e "SELECT COUNT(*) FROM mysql.user WHERE User='root' AND Host='%';") -gt 0 ]]; then
  echo "User root already exists, skipping creation."
else
  # Create root user
  echo "Creating root user ..."
  mysql -e "CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
  mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO 'root'@'%';"
  mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO 'root'@'%';"
fi

# Check if read/write/delete user exists
if [[ $(mysql -e "SELECT COUNT(*) FROM mysql.user WHERE User='${MYSQL_USER}' AND Host='%';") -gt 0 ]]; then
  echo "User ${MYSQL_USER} already exists, skipping creation."
else
  # Create read/write/delete user
  echo "Creating user ${MYSQL_USER} ..."
  mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
  mysql -e "GRANT SELECT, INSERT, UPDATE, DELETE ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
  mysql -e "GRANT SELECT, INSERT, UPDATE, DELETE ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
fi

mysql -e "FLUSH PRIVILEGES;"
