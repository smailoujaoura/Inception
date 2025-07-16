FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y apache2 php php-mysql curl
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

RUN curl -L -o /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php
RUN rm /var/www/html/index.html

CMD ["apachectl", "-D", "FOREGROUND"]
