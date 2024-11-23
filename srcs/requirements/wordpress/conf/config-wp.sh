#!/bin/sh
set -e  # Exit immediately on error

echo "Starting WordPress configuration script..."
sleep 10

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "wp-config.php not found. Creating wp-config.php with the provided database settings."

    wp config create --allow-root \
                     --dbname=$SQL_DATABASE \
                     --dbuser=$SQL_USER \
                     --dbpass=$SQL_PASSWORD \
                     --dbhost=mariadb \
                     --path='/var/www/wordpress'

    if [ -f /var/www/wordpress/wp-config.php ]; then
        echo "wp-config.php successfully created."
    else
        echo "Error: wp-config.php was not created. Check WP-CLI output."
    fi
else
    echo "wp-config.php already exists. Skipping WordPress configuration."
fi

echo "Starting PHP-FPM..."

exec "$@"
