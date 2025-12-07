compose_file	=		./srcs/docker-compose.yml
env_file		=		./srcs/.env.local

all: up

up: volumes
	@docker compose --file $(compose_file) --env-file $(env_file) up -d --build

volumes:
	@mkdir -p /home/$(USER)/data/wordpress
	@mkdir -p /home/$(USER)/data/mariadb

down:
	@docker compose --file $(compose_file) --env-file $(env_file) down

clean: down
	@docker system prune -af

fclean: clean
	@sudo rm -rf /home/$(USER)/data/wordpress/*
	@sudo rm -rf /home/$(USER)/data/mariadb/*
	@docker volume rm $(docker volume ls -q) 2>/dev/null || true

re: fclean all

