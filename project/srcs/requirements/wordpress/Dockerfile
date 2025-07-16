FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y php php-fpm php-mysql wget tar curl unzip mariadb-client php-redis
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./tools /scripts

RUN chmod +x /scripts/setup_wordpress.sh

CMD ["/scripts/setup_wordpress.sh"]