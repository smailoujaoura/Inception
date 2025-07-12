#!/bin/sh

mkdir -p /etc/nginx/ssl
openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 \
	-keyout /etc/nginx/ssl/selfsigned.key \
	-out /etc/nginx/ssl/selfsigned.crt \
	-subj "/CN=soujaour.42.fr"

cp /scripts/default.conf /etc/nginx/sites-available/default

exec nginx -g "daemon off;"