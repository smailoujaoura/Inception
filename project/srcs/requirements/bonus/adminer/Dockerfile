FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y php adminer
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

RUN mv /usr/share/adminer/adminer.php /usr/share/adminer/index.php

CMD ["php", "-S", "0.0.0.0:80", "-t", "/usr/share/adminer"]
