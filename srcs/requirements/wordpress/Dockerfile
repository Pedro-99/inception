FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install php netcat-traditional curl php-fpm php-mysqli -y

COPY ./tools/init_wp.sh /init_wp.sh

RUN chmod +x /init_wp.sh

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /bin/wp

WORKDIR /var/www/html

ENTRYPOINT [ "/init_wp.sh" ]

ENTRYPOINT [ "/init_wp.sh" ]