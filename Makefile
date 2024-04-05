COMPOSE_FILE := ./srcs/docker-compose.yml
DOCKER_COMPOSE := docker compose

.DEFAULT_GOAL := up

up:
	sudo mkdir -p /home/ivork/data/database
	sudo mkdir -p /home/ivork/data/site
	sudo $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up --build

down:
	sudo $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down --volumes --remove-orphans

prune: down
	sudo $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down --volumes --remove-orphans
	sudo docker system prune -af

clean:
	sudo docker stop $$(docker ps -qa) 2> /dev/null || exit 0
	sudo docker rm $$(docker ps -qa) 2> /dev/null || exit 0
	sudo docker rmi -f $$(docker images -qa) 2> /dev/null || exit 0
	sudo docker volume rm $$(docker volume ls -q) 2> /dev/null || exit 0
	sudo docker network rm $$(docker network ls -q) 2> /dev/null || exit 0
	sudo docker builder prune -f
	sudo rm -rf /home/ivork/data/database
	sudo rm -rf /home/ivork/data/site

.PHONY: up down prune clean

