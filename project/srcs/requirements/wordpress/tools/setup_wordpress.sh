#!/bin/sh

until mysqladmin ping -h mariadb --silent; do
	sleep 1
done

if wp core is-installed --allow-root; then
	echo "Wordpress is already installed."
	exec php-fpm7.4 -F
fi

cd /var/www/html
wp core download --alow-root
wp config create --dbname=${MYSQL_DATABASE} \
	--dbuser=${MYSQEL_USER} \
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

exec php-fpm7.4 -F