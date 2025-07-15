FROM debian:bullseye

RUN apt-get update \
  && apt-get install -y apache2 php php-mysql curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL -o /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php \
  && rm /var/www/html/index.html

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
