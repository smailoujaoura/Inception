FROM debian:bullseye

RUN apt-get update \
	&& apt-get install -y mariadb-server \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY ./tools/setup_mariadb.sh /scripts/setup_mariadb.sh
COPY ./tools/my.cnf /etc/mysql/my.cnf

RUN chmod +x /scripts/setup_mariadb.sh

CMD ["/scripts/setup_mariadb.sh"]