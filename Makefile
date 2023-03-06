COMPOSE_FILE=./srcs/docker-compose.yml

all: run

run: 
	@echo "$(GREEN)Building files for volumes ... $(RESET)"
	@sudo mkdir -p /home/rvrignon/data/wordpress
	@sudo mkdir -p /home/rvrignon/data/mariadb
	@echo "$(GREEN)Building containers ... $(RESET)"
	@docker-compose -f $(COMPOSE_FILE) up --build

up:
	@echo "$(GREEN)Building files for volumes ... $(RESET)"
	@sudo mkdir -p /home/rvrignon/data/wordpress
	@sudo mkdir -p /home/rvrignon/data/mariadb
	@echo "$(GREEN)Building containers in background ... $(RESET)"
	@docker-compose -f $(COMPOSE_FILE) up -d --build

down:
	@echo "$(RED)Stopping containers ... $(RESET)"
	@docker-compose -f $(COMPOSE_FILE) down

clean: down
	@echo "$(RED)Deleting all images ... $(RESET)"
	@-docker rmi -f `docker images -qa`
	@echo "$(RED)Deleting all volumes ... $(RESET)"
	@-docker volume rm `docker volume ls -q`
	@echo "$(RED)Deleting all network ... $(RESET)"
	@-docker network rm `docker network ls -q`
	@echo "$(RED)Deleting all data ... $(RESET)"
	@sudo rm -rf /home/rvrignon/data/wordpress
	@sudo rm -rf /home/rvrignon/data/mariadb
	@echo "$(RED)Deleting all $(RESET)"

.PHONY: run up debug list list_volumes clean
