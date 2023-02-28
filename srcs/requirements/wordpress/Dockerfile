FROM debian:buster

# Install packages required for WordPress and PHP-FPM
RUN apt-get update && apt-get install -y \
    netcat \
    curl \
    php-fpm \
    php-mysql \
    && rm -rf /var/lib/apt/lists/*

# Copy script to container
COPY conf/wordpress-init.sh /usr/src/wordpress-init.sh

# Set permissions on script
RUN chmod +x /usr/src/wordpress-init.sh

# Copy PHP-FPM configuration file
COPY conf/php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf

# Expose port 9000 for PHP-FPM connections
EXPOSE 9000

# Run script to initialize WordPress
CMD ["/usr/src/wordpress-init.sh"]
