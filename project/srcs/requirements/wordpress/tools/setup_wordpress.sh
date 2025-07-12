#!/bin/sh

set -ex

echo "proof 1" 1>&2

# Wait for MariaDB to be ready
until mysqladmin ping -h mariadb -u root -p"$MYSQL_ROOT_PASSWORD" --silent; do
    echo "Waiting for mariaDB"
    sleep 5
done

echo "proof 2" 1>&2

cd /var/www/html

# Check if WordPress is already installed
if wp core is-installed --allow-root --path=/var/www/html; then
    echo "WordPress is already installed."
else
    echo "proof 3" 1>&2

    # Download and install WordPress
    wp core download --allow-root
    wp config create --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost=mariadb \
        --allow-root

    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email=admin@"${DOMAIN_NAME}" \
        --skip-email \
        --allow-root

    wp user create "${WP_USER}" user@"${DOMAIN_NAME}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --allow-root
fi

# Configure PHP-FPM to listen on TCP port 0.0.0.0:9000
echo "Configuring PHP-FPM to listen on 0.0.0.0:9000" 1>&2
sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's|;listen.mode = 0660|listen.mode = 0660|' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's|;listen.allowed_clients = 127.0.0.1|listen.allowed_clients = any|' /etc/php/7.4/fpm/pool.d/www.conf

# Ensure /run/php directory exists
mkdir -p /run/php

# Verify PHP-FPM configuration
php-fpm7.4 -t

# Start PHP-FPM in foreground
exec php-fpm7.4 -F