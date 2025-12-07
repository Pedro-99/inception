FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install nginx openssl gettext-base -y && mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/bzinedda.key -out /etc/nginx/ssl/bzinedda.cert \
    -subj "/C=MA/ST=bm-kh/L=Khouribga/O=42-1337/OU=IT/CN=*.42.fr"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
