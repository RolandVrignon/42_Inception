#!/bin/bash

# Wait for MariaDB container to start
until nc -z -v -w30 mariadb 3306
do
  echo "Waiting for database connection..."
  # Wait for 5 seconds before checking again
done

sleep 30000000

# Download and extract latest WordPress
curl -o wordpress.tar.gz -SL https://wordpress.org/latest.tar.gz && \
tar -xzvf wordpress.tar.gz && \
rm wordpress.tar.gz && \
mv wordpress/* /var/www/html/ && \
chown -R www-data:www-data /var/www/html/

# Create wp-config.php
cat > /var/www/html/wp-config.php << EOF
<?php
define('DB_NAME', '${WORDPRESS_DB_NAME}');
define('DB_USER', '${WORDPRESS_DB_USER}');
define('DB_PASSWORD', '${WORDPRESS_DB_PASSWORD}');
define('DB_HOST', '${WORDPRESS_DB_HOST}');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
\$table_prefix = 'wp_';
define('WP_DEBUG', false);
if ( !defined('ABSPATH') )
  define('ABSPATH', dirname(__FILE__) . '/');
require_once(ABSPATH . 'wp-settings.php');
EOF

# Set permissions on wp-config.php
chown www-data:www-data /var/www/html/wp-config.php

