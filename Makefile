# Makefile for Docker setup

# Variables
COMPOSE_FILE = srcs/docker-compose.yml

# Rule to build and start the Docker services
all:
	docker compose -f $(COMPOSE_FILE) up --build

# Rule to stop and clean all Docker resources related to the project
clean:
	@echo "Stopping all running containers..."
	docker compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
	@echo "Removing all unused Docker resources..."
	docker system prune --all --volumes --force
	rm -rf ./srcs/mariadb/*
	rm -rf ./srcs/wordpress/*
	@echo "Clean-up complete!"

# Rule to just stop containers without removing volumes or images
stop:
	docker compose -f $(COMPOSE_FILE) down

re: clean all