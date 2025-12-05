
compose_file	=		./srcs/docker-compose.yml

up:
	@docker compose --file $(compose_file) up -d --build

ps:
	@echo -n "enter a commit message: "
	@git add . && read commit && git commit -m "$$commit" && git push