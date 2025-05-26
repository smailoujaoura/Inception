FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php php-fpm php-mysql wget unzip \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.zip \
	&& unzip latest.zip && mv wordpress/* . && rm -rf wordpress latest.zip

EXPOSE 9000

CMD ["php-fpm", "-F"]