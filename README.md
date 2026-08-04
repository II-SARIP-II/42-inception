_This project has been created as part of the 42 curriculum by pgougne._

![42 banners](assets/42banner.jpg)

# Description

# Instructions

Building images and starting containers:
> make all

___

Building images:
> make build
___

Starting containers: 
> make up
___

Stopping containers:
> make down
___

Cleaning containers, networks, and images:
> make clean
___

Cleaning containers, networks, and images and Deleting /data directories:
> make fclean


# Resources
https://www.golinuxcloud.com/install-deb-file-debian/
https://dev.to/bobrundle/how-to-fix-wordpress-error-establishing-a-database-connection-idl
https://cs4118.github.io/dev-guides/vm-ssh.html
https://www.debian.org/releases/bookworm/debian-installer/
https://redis.io/tutorials/operate/orchestration/docker/
https://mariadb.com/docs/server/server-management/automated-mariadb-deployment-and-administration/docker-and-mariadb/installing-and-using-mariadb-via-docker
https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose
https://indumathimanivannan.medium.com/docker-network-modes-explained-bridge-host-and-overlay-comparisons-d691857f9d30
https://www.geeksforgeeks.org/devops/docker-or-virtual-machines-which-is-a-better-choice/
https://thisvsthat.io/environment-variables-vs-secrets



# Additionnal sections

## Virtual Machines vs Docker
![Docker vs VM](assets/Docker-vs-VM.png)
![Docker vs VM](assets/compare-vm-docker.png)

## Secrets vs Environment Variables
Environment variables and secrets are both used to store sensitive information in a secure manner. However, environment variables are typically used to store configuration settings that are not considered highly sensitive, such as API keys or database connection strings. On the other hand, secrets are used to store highly sensitive information, such as passwords or encryption keys, and are typically encrypted at rest and in transit.
![secrets vs env](assets/secret-vs-env.png)

## Docker Network vs Host Network
Docker Network (Bridge) mode creates an isolated network for containers, allowing them to communicate with each other and the host through a virtual bridge, while Host Network mode allows containers to share the host's network stack directly, providing higher performance but less isolation.

## Docker Volumes vs Bind Mounts
![Docker volumes vs bind mounts](assets/docker-volume-vs-bin-mounts.png)
Docker volume and Bind mount are the docker components. Using bind mounts, you may mount a file or directory from your host computer onto your container and access it using its absolute path. Because Docker does everything independently, it is not dependent on the host computer's operating system or your directory structure. The Docker CLI commands or the Docker API may be used to manage Docker Volumes. It is safer to share quantities among many containers. The host computer's absolute path to the file or directory serves as a point of reference. Conversely, when a volume is used, Docker makes a new directory in the host machine's storage directory and keeps it updated.
