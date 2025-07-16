FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y --no-install-recommends lighttpd
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

COPY ./index.html /var/www/html/index.html

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
