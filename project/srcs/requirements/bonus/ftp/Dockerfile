FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y vsftpd openssl
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/setup.sh /setup.sh

RUN chmod +x /setup.sh

CMD ["/setup.sh"]