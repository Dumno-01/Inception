COMPOSE_FILE = srcs/docker-compose.yml

all:
	mkdir -p /home/ffreze/data/mariadb
	mkdir -p /home/ffreze/data/wordpress
	docker compose -f $(COMPOSE_FILE) up --build

clean:
	@echo "Stopping all running containers..."
	docker compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
	@echo "Removing all unused Docker resources..."
	docker system prune --all --volumes --force
	rm -rf /home/ffreze/data/mariadb/*
	rm -rf /home/ffreze/data/wordpress/*
	@echo "Clean-up complete!"

stop:
	docker compose -f $(COMPOSE_FILE) down

re: clean all