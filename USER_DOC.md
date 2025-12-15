# USER_DOC — User Documentation

## Overview

This stack provides a complete Wordpress website served over HTTPS using NGINX, PHP-FPM, and MariaDB. Everything runs inside Docker containers that communicate over an internal Docker network. Only NGINX is exposed to the outside world.

the services provided are:

* **NGINX** — handles HTTPS traffic and serves the website
* **WordPress (PHP-FPM)** — runs the WordPress application
* **MariaDB** — stores WordPress data

---

## Starting the Project

at the root of the repository, simply run:

```
make all
```

this will:

* build the Docker images
* create the containers
* create necessary volumes
* start the entire stack

if you only want to start the already-built services:

```
make up
```

---

## Stopping the Project

To stop all running containers:

```
make down
```

---

## Accessing the Website and Admin Panel

once the stack is running:

* Go to **[https://junruh.42.fr](https://junruh.42.fr)** in your browser
* To log in as administrator, go to:
  **[https://junruh.42.fr/wp-admin](https://junruh.42.fr/wp-admin)**

Your login credentials are stored in Docker secrets, not inside the repository.

---

## Locating and Managing Credentials

credentials are stored in the `secrets/` directory at the repository root:

these files:

* are **ignored by git**
* are mounted inside containers at runtime
* can be edited safely by the administrator

## Checking That Services Are Running

to list active containers:

```
docker ps
```

You should see:

* `nginx`
* `wordpress`
* `mariadb`

to view container logs:

```
docker logs <service>
```

to enter MariaDB:

```
docker exec -it mariadb mysql -u root -p
```

to enter a container’s shell:

```
docker exec -it <service> bash
```

---

## Where Data Is Stored

two Docker volumes store your data:

* `/home/junruh/data/inception_database` — MariaDB database
* `/home/junruh/data/inception_website` — WordPress files (themes, plugins, uploads)

These directories persist even if containers are rebuilt.
