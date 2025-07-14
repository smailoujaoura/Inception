#!/bin/sh

set -ex

until mysqladmin ping -h mariadb -u root -p"$MYSQL_ROOT_PASSWORD" --silent; do
	echo "Waiting for mariaDB"
	sleep 5
done

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
echo "listen = 9000" >> /etc/php/7.4/fpm/pool.d/www.conf

cd /var/www/html

mkdir -p /run/php

chmod -R 775 /var/www/html
chown -R www-data:www-data /var/www/html

if wp core is-installed --allow-root --path=/var/www/html; then
    echo "WordPress is already installed."
	wp config set WP_CACHE true --allow-root
	wp config set WP_REDIS_HOST redis --allow-root
	wp config set WP_REDIS_PORT 6379 --allow-root
	wp plugin install redis-cache --activate --allow-root
	wp redis enable --allow-root
    exec php-fpm7.4 -F
fi

cd /var/www/html
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
	--admin_email=admin@${DOMAIN_NAME} \
	--skip-email \
	--allow-root

wp user create ${WP_USER} user@${DOMAIN_NAME} \
	--user_pass=${WP_USER_PASSWORD} \
	--allow-root

chmod -R 775 /var/www/html
chown -R www-data:www-data /var/www/html

wp config set WP_CACHE true --allow-root
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root

wp plugin install redis-cache --activate --allow-root
wp redis enable --allow-root

exec php-fpm7.4 -F
