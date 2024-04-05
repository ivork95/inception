COMPOSE_FILE := ./srcs/docker-compose.yml
DOCKER_COMPOSE := docker compose

.DEFAULT_GOAL := up

up:
	mkdir -p /home/ivork/data/database
	mkdir -p /home/ivork/data/site
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up --build

down:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down --volumes --remove-orphans

prune: down
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down --volumes --remove-orphans
	docker system prune -af

clean:
	docker stop $$(docker ps -qa) 2> /dev/null || exit 0
	docker rm $$(docker ps -qa) 2> /dev/null || exit 0
	docker rmi -f $$(docker images -qa) 2> /dev/null || exit 0
	docker volume rm $$(docker volume ls -q) 2> /dev/null || exit 0
	docker network rm $$(docker network ls -q) 2> /dev/null || exit 0
	docker builder prune -f
	sudo rm -rf /home/ivork/data/database
	sudo rm -rf /home/ivork/data/site

.PHONY: up down prune clean

