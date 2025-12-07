FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install php netcat-traditional curl php-fpm php-mysqli mariadb-client -y

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /bin/wp

COPY ./tools/init_wp.sh /init_wp.sh

RUN chmod +x /init_wp.sh

RUN sed -i 's#listen = /run/php/php8.2-fpm.sock#listen = 0.0.0.0:9000#' /etc/php/8.2/fpm/pool.d/www.conf

WORKDIR /var/www/html

ENTRYPOINT [ "/init_wp.sh" ]
