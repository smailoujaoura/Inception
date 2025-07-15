FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN curl -L https://downloads.portainer.io/ce2-25/portainer \
    -o /app/portainer && \
    chmod +x /app/portainer

EXPOSE 9443

CMD ["/app/portainer", "--data", "/app/data", "--bind", ":9443"]
