compose_file = ./srcs/docker-compose.yml

all: up

up: volumes
	@docker compose --file $(compose_file) up -d --build

volumes:
	@mkdir -p /home/$(USER)/data/wordpress
	@mkdir -p /home/$(USER)/data/mariadb

down:
	@docker compose --file $(compose_file) down

clean: down
	@docker system prune -af

fclean: clean
	@sudo rm -rf /home/$(USER)/data/wordpress/*
	@sudo rm -rf /home/$(USER)/data/mariadb/*
	@docker volume rm $$(docker volume ls -q | grep -E "wordpress|mariadb") 2>/dev/null || true

re: fclean up

