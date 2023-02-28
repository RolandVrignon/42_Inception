FROM debian:buster

# Install packages required for WordPress and Apache
RUN apt-get update && apt-get install -y \
    apache2 \
    libapache2-mod-php \
    php \
    php-mysql \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-xmlrpc \
    php-soap \
    && rm -rf /var/lib/apt/lists/*

# Copy script to container
COPY configure-wordpress.sh /configure-wordpress.sh

# Set permissions on script
RUN chmod +x /configure-wordpress.sh

# Download and extract latest WordPress
RUN curl -o wordpress.tar.gz -SL https://wordpress.org/latest.tar.gz && \
    tar -xzvf wordpress.tar.gz && \
    rm wordpress.tar.gz && \
    mv wordpress /var/www/html/wordpress && \
    chown -R www-data:www-data /var/www/html/wordpress

# Copy Apache configuration file
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Enable Apache modules
RUN a2enmod rewrite

# Expose port 9000 for HTTP connections
EXPOSE 9000

# Run script to configure WordPress
CMD ["/configure-wordpress.sh"]
