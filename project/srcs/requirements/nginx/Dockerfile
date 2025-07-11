FROM debian:bullseye

RUN apt-get update \
	&& apt-get install -y --no-install-recommends nginx openssl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# RUN mkdir -p /etc/nginx/ssl \
# 	&& openssl req -x509 -nodes -days 365 \
# 	-newkey rsa:2048 \
# 	-keyout /etc/nginx/ssl/nginx-selfsigned.key \
# 	-out /etc/nginx/ssl/nginx-selfsigned.crt \
# 	-subj "/CN=name.name.com"
# RUN mkdir -p /var/www/wordpress /var/run/nginx \
# 	&& chmod 755 /var/www/wordpress \
# 	&& chown -R www-data:www-data /var/www/wordpress
# EXPOSE 443
# CMD ["nginx", "-g", "daemon off;"]
# COPY default.conf /etc/nginx/conf.d/

COPY ./tools /scripts

RUN chmod +x /scripts/setup_nginx.sh

ENTRYPOINT ["/scripts/setup_nginx.sh"]