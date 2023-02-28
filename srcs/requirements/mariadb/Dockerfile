FROM debian:buster

# Install MariaDB server and client
RUN apt-get update && apt-get install -y mariadb-server mariadb-client && rm -rf /var/lib/apt/lists/*

# Copy SQL script to container
COPY conf/database.sql /docker-entrypoint-initdb.d/

# Set permissions on SQL script
RUN chmod 755 /docker-entrypoint-initdb.d/database.sql

# Expose port 3306 for MySQL connections
EXPOSE 3306

# Start MariaDB server
CMD ["mysqld", "--user=mysql"]
