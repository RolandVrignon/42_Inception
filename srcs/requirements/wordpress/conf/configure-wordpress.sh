#!/bin/bash

# Wait for MariaDB container to start
until nc -z -v -w30 mariadb 3306
do
  echo "Waiting for database connection..."
  # Wait for 5 seconds before checking again
  sleep 5
done

# Create wp-config.php
cat > /var/www/html/wordpress/wp-config.php << EOF
<?php
define('DB_NAME', '${MYSQL_DATABASE}');
define('DB_USER', '${MYSQL_USER}');
define('DB_PASSWORD', '${MYSQL_PASSWORD}');
define('DB_HOST', '${MYSQL_HOST}');
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
chown www-data:www-data /var/www/html/wordpress/wp-config.php

# Start Apache
