#!/bin/sh

mysql_install_db

/etc/init.d/mysql start

#Check if the database exists

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then 
	echo "Database already exists"
else

# Set root option so that connexion without root password is not possible

mysql_secure_installation << _EOF_

Y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
n
Y
Y
_EOF_

echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

#Create database and user in the database for wordpress
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" | mysql -u root
echo "CREATE USER '$MYSQL_ADMIN_USER'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD';" | mysql -u root
echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root

echo "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_ADMIN_USER'@'%';" | mysql -u root
echo "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';" | mysql -u root

echo "FLUSH PRIVILEGES;" | mysql -u root

#Import database in the mysql command line
mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql

# Générer un hachage de mot de passe MD5 pour l'utilisateur $MYSQL_ADMIN_USER
MYSQL_ADMIN_PASSWORD_HASH=$(mkpasswd -m md5 $MYSQL_ADMIN_PASSWORD)
MYSQL_PASSWORD_HASH=$(mkpasswd -m md5 $MYSQL_PASSWORD)

# Ajouter les utilisateurs à la base de données WordPress
echo "INSERT INTO wp_users VALUES (1, '$MYSQL_ADMIN_USER','$MYSQL_ADMIN_PASSWORD_HASH','$MYSQL_ADMIN_USER','$WP_ADMIN_EMAIL','$WP_DOMAIN','2022-09-28 15:59:52','',0,'$MYSQL_ADMIN_USER'), (2, '$MYSQL_USER','$MYSQL_PASSWORD_HASH','$MYSQL_USER','$WP_USER_EMAIL','$WP_DOMAIN','2022-09-28 15:59:52','',0,'$MYSQL_USER');" | mysql -u root $MYSQL_DATABASE
fi

/etc/init.d/mysql stop

exec "$@"
