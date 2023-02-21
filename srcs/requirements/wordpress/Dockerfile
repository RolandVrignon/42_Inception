FROM debian:buster

RUN apt update -y && apt upgrade -y \
&& apt install -y php7.3 \
    php-fpm \
    php-mysql \
    mariadb-client \
    wget \
    curl \
    bash \
&& wget https://fr.wordpress.org/wordpress-6.1.1-fr_FR.tar.gz -P /var/www/html \
&& cd /var/www/html \
&& tar -xzf wordpress-6.1.1-fr_FR.tar.gz \
&& rm wordpress-6.1.1-fr_FR.tar.gz

