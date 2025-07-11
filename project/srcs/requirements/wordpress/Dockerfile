FROM debian:bullseye

RUN apt-get update \
	&& apt-get install -y php php-fpm php-mysql wget tar curl unzip less mariadb-client \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
	
# WORKDIR /var/www/html
# RUN wget https://wordpress.org/latest.zip \
# 	&& unzip latest.zip && mv wordpress/* . && rm -rf wordpress latest.zip
# EXPOSE 9000

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000 
# OPTIONAL 

COPY ./tools /scripts

RUN chmod +x /scripts/setup_wordpress.sh

ENTRYPOINT ["/scripts/setup_wordpress.sh"]