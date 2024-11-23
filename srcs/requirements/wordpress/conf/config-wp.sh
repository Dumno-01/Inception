#!/bin/bash

cd /var/www/html

if [ -f "wp-config.php" ]; then
    echo "WordPress already initialized"
else
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar

    # Download WordPress and set up configuration
    ./wp-cli.phar core download --locale=en_GB --allow-root
    ./wp-cli.phar config create --allow-root \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="${WORDPRESS_DB_PASSWORD}" \
        --dbhost="${WORDPRESS_DB_HOST}"

    ./wp-cli.phar core install --allow-root \
        --url="https://${NGINX_HOST}" \
        --title="${COMPOSE_PROJECT_NAME}" \
        --admin_user="${WORDPRESS_ADMIN}" \
        --admin_password="${WORDPRESS_ADMIN}" \
        --admin_email="${WORDPRESS_ADMIN_MAIL}"

    chown -R www-data:www-data /var/www/html/wp-content/
fi

exec "$@"
