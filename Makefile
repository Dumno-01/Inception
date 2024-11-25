COMPOSE_FILE = srcs/docker-compose.yml

all:
	chmod 777 ./srcs/mysql-data
	chmod 777 ./srcs/mysqld-socket
	chown -R 999:999 ./srcs/mysql-data
	chown -R 999:999  ./srcs/mysqld-socket
	docker compose -f $(COMPOSE_FILE) up --build

clean:
	@echo "Stopping all running containers..."
	docker compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
	@echo "Removing all unused Docker resources..."
	docker system prune --all --volumes --force
	rm -rf ./srcs/mysql-data/*
	rm -rf ./srcs/mysqld-socket/*
	rm -rf ./srcs/wordpress/*
	@echo "Clean-up complete!"

stop:
	docker compose -f $(COMPOSE_FILE) down

re: clean all