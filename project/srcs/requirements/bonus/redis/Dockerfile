FROM debian:bullseye

RUN apt-get update \
	&& apt-get install -y --no-install-recommends redis-server \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 6379

ENTRYPOINT ["redis-server", "--protected-mode", "no"]
