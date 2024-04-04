# Variables
COMPOSE_FILE := ./srcs/docker-compose.yml
DOCKER_COMPOSE := docker-compose

# Phony targets
.PHONY: up rebuild prune clean

# Default target
.DEFAULT_GOAL := up

# Rule for starting the containers
up:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up --build

# Rule for rebuilding if the compose file has changed
rebuild: $(COMPOSE_FILE)
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up --build

# Rule for pruning containers, images, and volumes
down:
	docker volume rm $$(docker volume ls -q) 2> /dev/null || exit 0
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down --volumes --remove-orphans

prune: down
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down --volumes --remove-orphans
	docker system prune -af
# docker rmi $(docker images -a -q)

# $$ is an escaped $, and it gives sh, rather than Make, the chance to expand it
# 2> /dev/null ignores errors when $$(docker ps -qa) expands to an empty result
# Likewise, || exit 0 makes sure Make doesn't report an error
clean:
	docker stop $$(docker ps -qa) 2> /dev/null || exit 0
	docker rm $$(docker ps -qa) 2> /dev/null || exit 0
	docker rmi -f $$(docker images -qa) 2> /dev/null || exit 0
	docker volume rm $$(docker volume ls -q) 2> /dev/null || exit 0
	docker network rm $$(docker network ls -q) 2> /dev/null || exit 0
	docker builder prune -f
#sudo rm -rf $(VOLUME_DIR)
