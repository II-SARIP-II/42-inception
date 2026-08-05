# Inception - User Documentation

## Commands

* **Start the project:** `make` or `make all`
* **Stop the project:** `make down`
* **Restart after stop:** `make up`
* **Clean everything (volumes, images, networks):** `make fclean`

## Credentials & Setup

Before starting, copy the required `.env` and secrets files if needed:
```bash
cp ~/secrets/ .
cp srcs/.env .

## Services:

### Wordpress site:
https://pgougne.42.fr or https://pgougne.42.fr:443
https://pgougne.42.fr/wp-admin

### Redis (Object Cache)

An in-memory data structure store integrated with WordPress as an object cache. It speeds up page loading times by caching database query results, significantly reducing MariaDB workload.\
https://localhost/wp-admin

### FTP Server (vsftpd)

A secure File Transfer Protocol server targeting the WordPress web directory (/var/www/html). It enables seamless remote file management and direct upload/download of site assets using system credentials.\
curl -T /etc/hosts ftp://127.0.0.1:21/test.txt --user "pgougne:UserPass123"
docker exec -it wordpress ls -la /var/www/html/

### Adminer (Database Management)

A lightweight, single-file web-based database management tool listening on port 8080. It provides a simple graphical interface to inspect, query, and manage the MariaDB database without using CLI tools.
http://localhost:8080/adminer.php

### Static Website

A standalone static HTML/CSS web page served by a dedicated Nginx server on port 8081. It operates completely independently from the main WordPress application to showcase multi-site serving.\
http://localhost:8081/

### cAdvisor (Container Monitoring)

Google's Container Advisor running on port 8082. It collects, aggregates, and visualizes real-time performance metrics (CPU usage, memory consumption, network activity) for all running Docker containers.\
http://localhost:8082/


# Check Services

> docker ps

view logs
> docker logs <container_name>

