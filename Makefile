LOGIN = pgougne
DATA_PATH = /home/$(LOGIN)/data
COMPOSE_FILE = srcs/docker-compose.yml

all: build up

build:
	@echo "creating data directories"
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/mariadb

	@echo "Building docker images"
	@docker compose -f $(COMPOSE_FILE) build

up:
	@echo "starting containers"
	@docker compose -f $(COMPOSE_FILE) up -d

down:
	@echo "Turning off containers"
	@docker compose -f $(COMPOSE_FILE) down

clean: down
	@echo "Cleaning containers and images"
	@docker compose -f $(COMPOSE_FILE) down --rmi all -v

fclean: clean
	@echo "Deleting data and volumes"
	@docker system prune -a --volumes -f
	@sudo rm -rf $(DATA_PATH)/wordpress/*
	@sudo rm -rf $(DATA_PATH)/mariadb/*

re: fclean all

.PHONY: all build up down clean fclean re