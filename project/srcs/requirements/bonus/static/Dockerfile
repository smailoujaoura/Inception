FROM debian:bullseye

RUN apt-get update \
	&& apt-get install -y --no-install-recommends lighttpd \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY ./index.html /var/www/html/index.html

EXPOSE 80

ENTRYPOINT ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
