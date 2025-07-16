FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y --no-install-recommends nginx openssl
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

COPY ./conf/default /etc/nginx/sites-enabled/default
COPY ./tools/setup_nginx.sh /scripts/setup_nginx.sh

RUN chmod +x /scripts/setup_nginx.sh

CMD ["/scripts/setup_nginx.sh"]