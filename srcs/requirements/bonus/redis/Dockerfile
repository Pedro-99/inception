FROM	debian:bookworm

RUN		apt update && apt upgrade -y && \
		apt install -y redis netcat

ENTRYPOINT \
["redis-server", "--bind", "0.0.0.0", "--protected-mode", "no"]