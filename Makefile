DOCKER_COMPOSE=docker-compose -f ./srcs/docker-compose.yml

DATA_DIR = /home/junruh/data
DB_DIR = /home/junruh/data/inception_database
WP_DIR = /home/junruh/data/inception_website
DB_VOL = inception_database
WP_VOL = inception_website

all: build up

volumes:
	@mkdir -p $(DB_DIR)
	@mkdir -p $(WP_DIR)
#	@sudo chown -R 999:999 $(DB_DIR)
#	@sudo chown -R 999:999 $(WP_DIR)
#	@if [ ! -d $(DATA_DIR) ]; then \
#		mkdir -p $(DATA_DIR); \
	fi
	@if ! docker volume inspect $(DB_VOL) >/dev/null 2>&1; then \
		echo "Creating bind mount volume $(DB_VOL)..."; \
		docker volume create \
			--driver local \
			--opt type=none \
			--opt device=$(DB_DIR) \
			--opt o=bind \
			$(DB_VOL); \
	fi
	@if ! docker volume inspect $(WP_VOL) >/dev/null 2>&1; then \
		echo "Creating bind mount volume $(WP_VOL)..."; \
		docker volume create \
			--driver local \
			--opt type=none \
			--opt device=$(WP_DIR) \
			--opt o=bind \
			$(WP_VOL); \
	fi

build:
	${DOCKER_COMPOSE} build

up: volumes
	${DOCKER_COMPOSE} up -d

down:
	${DOCKER_COMPOSE} down

downanddelete:
	${DOCKER_COMPOSE} down -v
	docker volume rm inception_database
	docker volume rm inception_website
	sudo rm -rf $(DATA_DIR)

pause:
	${DOCKER_COMPOSE} pause

unpause:
	${DOCKER_COMPOSE} unpause