FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install mariadb-server netcat-traditional -y

COPY ./tools/init_db.sh .

RUN chmod +x init_db.sh

ENTRYPOINT [ "/init_db.sh" ]