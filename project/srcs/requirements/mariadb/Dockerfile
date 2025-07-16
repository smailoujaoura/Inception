FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y mariadb-server
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

COPY ./tools/setup_mariadb.sh /scripts/setup_mariadb.sh
COPY ./conf/my.cnf /etc/mysql/my.cnf

RUN chmod +x /scripts/setup_mariadb.sh

CMD ["/scripts/setup_mariadb.sh"]