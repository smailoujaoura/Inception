FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y --no-install-recommends redis-server
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

CMD ["redis-server", "--protected-mode", "no"]
