# Developer Documentation

## Overview

This document explains how to set up, build, run, maintain, and debug the Inception project as a developer. It covers environment preparation, directory structure, Docker image creation, container orchestration, and data persistence.

---

# 1. Prerequisites

before building or running the project, ensure:

### System Requirements

* Virtual Machine running
* Docker installed
* Docker Compose installed

### Configuration Files Required

#### 1.1 `.env`

must define:

```
DOMAIN_NAME=junruh.42.fr
WP_DB_NAME=wordpress
WP_DB_USER=mariadb
DB_HOST=mariadb
```

and must me located in the srcs/ directory

#### 1.2 `secrets/` directory

contains secure credentials:

```
secrets/db_password.txt
secrets/db_root_password.txt
secrets/wp_pwd.txt
secrets/cert.pem
secrets/privkey.pem
```

Each file contains **only the password**, nothing else.

#### 1.3 `/etc/hosts`

Add:

```
127.0.0.1    junruh.42.fr
```

this allows the browser to resolve your domain locally.

---

# 2. Building the Project

all build commands are defined in the **Makefile** at the root.

### Build images and start containers

```
make all
```

this will:

* build the custom images from `srcs/requirements/*/Dockerfile`
* run Docker Compose and start all services

### Build images only

```
make build
```

Containers will be created but not started.

### Create only volumes

```
make volumes
```

Used when testing persistence behavior.

---

# 3. Running & Stopping the Stack

### Start the project

```
make up
```

### Stop all running containers

```
make down
```

### Stop containers *and* remove volumes 

```
make downanddelete
```

**ATTENTION: This deletes all persistent WordPress and MariaDB data.**

### Pause / Resume containers

```
make pause
make unpause
```

---

# 4. Managing Containers

### Enter a running container

```
docker exec -it <container_name> bash
```

Examples:

```
docker exec -it wordpress bash
docker exec -it mariadb bash
docker exec -it nginx bash
```

### Check running services

```
docker ps
```

### Check container logs

```
docker logs wordpress
docker logs mariadb
docker logs nginx
```

use `-f` to follow logs live.

### Logging into mariadb DB & inspecting contents

```
docker exec -it mariadb mysql -u root -p
SHOW DATABASES;
USE mariadb;
SHOW TABLES;
```

---

# 5. Managing Volumes & Persistent Data

### List volumes

```
docker volume ls
```

### Inspect a volume

```
docker volume inspect <volume_name>
```

### Default persistent data locations

add paths here

---

# 6. Rebuilding Individual Services

### Rebuild a single image and restart its container

```
docker compose -f srcs/docker-compose.yml build <service>
docker compose -f srcs/docker-compose.yml up -d <service>
```

Example:

```
docker compose -f srcs/docker-compose.yml build wordpress
```

---

# 7. Development Tips

### If images do not rebuild correctly

Use:

```
docker compose -f srcs/docker-compose.yml build --no-cache
```

### If permissions become incorrect in WordPress or NGINX

Reset ownership:

```
chown -R www-data:www-data /var/www/html
```

### To fully reset the environment

```
make downanddelete
make all
```
