FROM debian:bullseye

RUN apt-get update \
	&& apt-get install -y --no-install-recommends curl ca-certificates gnupg git build-essential \
	&& curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
	&& apt-get install -y --no-install-recommends nodejs \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/louislam/uptime-kuma.git .

RUN npm run setup

EXPOSE 3001

CMD ["node", "server/server.js"]
