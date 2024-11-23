#!/bin/sh

# Logging environment variables for debugging
echo "SQL_ROOT_PASSWORD=${SQL_ROOT_PASSWORD}"
echo "SQL_DATABASE=${SQL_DATABASE}"
echo "SQL_USER=${SQL_USER}"
echo "SQL_PASSWORD=${SQL_PASSWORD}"

# Check if the data directory is empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    echo "Starting MariaDB with --skip-grant-tables for initialization..."
    mysqld_safe --skip-grant-tables &
    sleep 5

    echo "Setting up database and users..."
    # Use non-password commands initially
    mysql -u root <<EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
FLUSH PRIVILEGES;
EOF

    echo "Stopping MariaDB after initialization..."
    mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown
fi

echo "Starting MariaDB in normal mode..."
exec "$@"
