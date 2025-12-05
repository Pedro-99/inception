FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install php -y

WORKDIR /var/www/html

COPY ./tools/index.html index.html

ENTRYPOINT [ "php", "-S", "0.0.0.0:8080", "-t", "."]
