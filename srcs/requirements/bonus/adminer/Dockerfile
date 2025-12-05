FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install php curl -y && rm -rf /var/www/html/index.html

WORKDIR /var/www/html

RUN curl -o index.php https://www.adminer.org/latest.php 

ENTRYPOINT [ "php", "-S", "0.0.0.0:9090", "-t", "."]
