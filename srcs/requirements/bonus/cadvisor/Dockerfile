FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install wget -y

RUN wget -q https://github.com/google/cadvisor/releases/download/v0.49.1/cadvisor-v0.49.1-linux-amd64 \
    -O /usr/local/bin/cadvisor && \
    chmod +x /usr/local/bin/cadvisor

ENTRYPOINT ["/usr/local/bin/cadvisor"]