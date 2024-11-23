#!/bin/bash

# Ensure permissions for MySQL directories
chgrp -R mysql /var/lib/mysql
chmod -R g+rwx /var/lib/mysql

if [ -d "/var/lib/mysql/${SQL_DATABASE}" ]; then
    echo "Mariadb already initialized"
else
    # Initialize database if not already initialized
    if [ ! -d "/var/lib/mysql/mysql" ]; then
        mysql_install_db --user=mysql --ldata=/var/lib/mysql
    fi

    /etc/init.d/mariadb start

    mariadb << XEOFX
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
XEOFX

    /etc/init.d/mariadb stop
fi

exec "$@"
