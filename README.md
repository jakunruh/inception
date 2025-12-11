*This project has been created as part of the 42 curriculum by junruh*

# Description

Inception is a project from the 42 curriculum designed to introduce containerization using Docker/Docker Compose. The objective is to build a small multi-service web stack, using only custom-built Docker images based on Debian.

The project requires setting up:

* An NGINX container configured exclusively with TLSv1.2 or TLSv1.3.
* A WordPress container running WordPress with php-fpm, without NGINX.
* A MariaDB container configured to store the WordPress database.
* Two Docker-managed volumes: one for database files and one for WordPress site files.
* A Docker network to connect all services.
* A domain name (`junruh.42.fr`) pointing to the host's IP.

# Instructions

To use the application you need to have:
* Virtual Machine open (on school machine)
* Docker and Docker Compose installed
* proper '/etc/hosts' entry for 'junruh.42.fr'
* the secrets and environment variable files in the right place (secrets and repository root and .env in srcs/)


## Build & Run

At the project root there is a Makefile containing:

make all:
	* builds custom Docker images using the Dockerfiles in 'srcs/requirements/*'
	* creates and starts containers via 'docker-compose.yml'

make build:
	* builds custom Docker images using the Dockerfiles in 'srcs/requirements/*'
	* creates containers via 'docker-compose.yml'

make volumes:
	* creates Docker volumes and binds them to their designated host directory

make down:
	* stops all containers

make downanddelete: **USE WITH CAUTION**
	* stops all containers and deletes all volumes and bind mounts

make pause/ make unpause:
	* pauses/unpauses running containers

## Usage

after the above steps you can go to https::/junruh.42.fr to see the configured website and https::/junruh.42.fr/wp-admin to get to the wordpress configuration page

to enter any container you do:
* docker exec -it wordpress bash

if you want to manually log into the DB you can go to the terminal and do:
* docker exec -it mariadb mysql -u root -p
* SHOW DATABASES;
* USE mariadb;
* SHOW TABLES; (to see files)

# Virtual Machines vs Docker

**Virtual Machines:**

* full OS per VM
* heavy resource usage (having preallocated CPU, RAM, etc.)
* slow to boot and manage

**Docker Containers:**

* lightweight, share the host kernel
* faster to create, destroy, and change
* better suited for isolated services
* easy networking between different services
* portable


# Secrets vs Environment Variables

**Environment Variables:**

* simple, flexible, readable
* suitable for non-sensitive configuration (domain, usernames)
* risky for passwords if stored in git

**Docker Secrets:**

* mounted at runtime only
* never appear in environment or image layers
* ideal for passwords, certificates, other sensitive information


# Docker Network vs Host Network

**Host Network:**

* Container shares host's networking stack
> no isolation
>>security risk
>>possible port conflict
>>loses portability because it depends on host OS

**Docker Bridge Network:**

* isolated internal network for containers
* easier to navigate
* more control (e.g. over ports)


# Docker Volumes vs Bind Mounts

**Bind Mounts:**

* map host directory into container
* can be insecure or inconsistent
* not stable for database storage

**Docker Volumes:**

* managed entirely by Docker
* more stable, portable, and secure
* perfect for persisting MariaDB and WordPress files

# Resources

## Documentation & References

* Docker Documentation: [https://docs.docker.com/]
* Docker Compose: [https://docs.docker.com/compose/]
* mariaDB: [https://mariadb.org/documentation/]
* WordPress: [https://developer.wordpress.org/]
* NGINX: [https://nginx.org/en/docs/]
* multiple Wikipedia entries
* lots of youtube tutorials 

## AI Usage

AI was used for:

* drafting documentation sections
* explaining/clarifying certain concepts related to the project, taking on a teacher's role
* understanding best practices for Dockerfile structure
* reviewing differences between Docker volumes, secrets, and networking options


