DOCKER_COMPOSE=docker-compose -f ./srcs/docker-compose.yml

all: build up

build:
	${DOCKER_COMPOSE} build

up:
	${DOCKER_COMPOSE} up -d

down:
	${DOCKER_COMPOSE} down

pause:
	${DOCKER_COMPOSE} pause

unpause:
	${DOCKER_COMPOSE} unpause