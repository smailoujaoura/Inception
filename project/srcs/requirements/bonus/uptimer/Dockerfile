FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y --no-install-recommends curl ca-certificates gnupg git build-essential
RUN curl -L https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y --no-install-recommends nodejs
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/louislam/uptime-kuma.git .

RUN npm run setup

CMD ["node", "server/server.js"]
