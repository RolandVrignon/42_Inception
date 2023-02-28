FROM debian:buster

RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server

# Configure Mariadb
RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld

COPY ./conf/my.cnf /etc/mysql/my.cnf

COPY ./conf/script.sh /script.sh
RUN chmod 755 /script.sh

EXPOSE 3306

CMD ["./script.sh"]
