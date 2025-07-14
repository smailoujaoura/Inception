FROM debian:bullseye

RUN apt-get update \
	&& apt-get install -y vsftpd openssl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY vsftpd.conf /etc/vsftpd.conf

COPY setup.sh /setup.sh

RUN chmod +x /setup.sh

EXPOSE 21

ENTRYPOINT ["/setup.sh"]