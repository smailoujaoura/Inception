FROM debian:bullseye

RUN apt-get update \
	&& apt-get install -y mariadb-server \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# COPY default.cnf /etc/mysql/mariadb.conf.d/default.cnf
# COPY init_maria.sh /usr/local/bin/init_maria.sh
# EXPOSE 3306

COPY ./tools /scripts

RUN chmod +x /scripts/setup_mariadb.sh

CMD ["/scripts/setup_mariadb.sh"]