COMPOSE_FILE=./srcs/docker-compose.yml

all: run

run: 
	@echo "$(GREEN)Building files for volumes ... $(RESET)"
	@sudo mkdir -p /home/rolexx/data/wordpress
	@sudo mkdir -p /home/rolexx/data/mariadb
	@echo "$(GREEN)Building containers ... $(RESET)"
	@docker-compose -f $(COMPOSE_FILE) up --build

up:
	@echo "$(GREEN)Building files for volumes ... $(RESET)"
	@sudo mkdir -p /home/rolexx/data/wordpress
	@sudo mkdir -p /home/rolexx/data/mariadb
	@echo "$(GREEN)Building containers in background ... $(RESET)"
	@docker-compose -f $(COMPOSE_FILE) up -d --build

debug:
	@echo "$(GREEN)Building files for volumes ... $(RESET)"
	@sudo mkdir -p /home/rolexx/data/wordpress
	@sudo mkdir -p /home/rolexx/data/mariadb
	@echo "$(GREEN)Building containers with log information ... $(RESET)"
	@docker-compose -f $(COMPOSE_FILE) --verbose up

list:	
	@echo "$(PURPLE)Listing all containers ... $(RESET)"
	 docker ps -a

list_volumes:
	@echo "$(PURPLE)Listing volumes ... $(RESET)"
	docker volume ls

clean: 	
	@echo "$(RED)Stopping containers ... $(RESET)"
	@docker-compose -f $(COMPOSE_FILE) down
	@-docker stop `docker ps -qa`
	@-docker rm `docker ps -qa`
	@echo "$(RED)Deleting all images ... $(RESET)"
	@-docker rmi -f `docker images -qa`
	@echo "$(RED)Deleting all volumes ... $(RESET)"
	@-docker volume rm `docker volume ls -q`
	@echo "$(RED)Deleting all network ... $(RESET)"
	@-docker network rm `docker network ls -q`
	@echo "$(RED)Deleting all data ... $(RESET)"
	@sudo rm -rf /home/rolexx/data/wordpress
	@sudo rm -rf /home/rolexx/data/mariadb
	@echo "$(RED)Deleting all $(RESET)"

.PHONY: run up debug list list_volumes clean
