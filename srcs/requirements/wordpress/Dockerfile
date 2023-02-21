FROM debian:buster

RUN apt-get update && apt-get -y install \
wget \
php \
php-cgi \
php-mysql \
php-fpm \
php-pdo \
php-gd php-cli \
php-mbstring \
&& rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /var/www/html/

RUN mkdir /run/php

COPY ./conf/script.sh /usr/local/bin/script.sh
RUN chmod a+x /usr/local/bin/script.sh
ENTRYPOINT ["/usr/local/bin/script.sh"]

WORKDIR /var/www/html/

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]