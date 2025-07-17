#!/bin/sh

set -ex

until mysqladmin ping -h mariadb -u root -p"$MYSQL_ROOT_PASSWORD" --silent; do
	echo "Waiting for mariaDB"
	sleep 5
done


mkdir -p /run/php
echo "listen = 9000" >> /etc/php/7.4/fpm/pool.d/www.conf
chown -R www-data:www-data /var/www/html
cd /var/www/html

if wp core is-installed --allow-root --path=/var/www/html; then
    echo "WordPress is already installed."
	wp redis enable --allow-root
    exec php-fpm7.4 -F
fi

wp core download --allow-root

wp config create --dbname=${MYSQL_DATABASE} \
	--dbuser=${MYSQL_USER} \
	--dbpass=${MYSQL_PASSWORD} \
	--dbhost=mariadb \
	--allow-root

wp core install \
	--url=${DOMAIN_NAME} \
	--title="Inception" \
	--admin_user=${WP_ADMIN_USER} \
	--admin_password=${WP_ADMIN_PASSWORD} \
	--admin_email=contact@${DOMAIN_NAME} \
	--skip-email \
	--allow-root

wp user create ${WP_USER} user@${DOMAIN_NAME} \
	--user_pass=${WP_USER_PASSWORD} \
	--allow-root

wp plugin install redis-cache --activate --allow-root
wp plugin activate redis-cache --allow-root

wp config set WP_CACHE true --allow-root
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root
wp redis enable --allow-root

chown -R www-data:www-data /var/www/html

exec php-fpm7.4 -F
