COMPOSE_PATH = srcs/docker-compose.yml

all:
	sudo docker-compose -f $(COMPOSE_PATH) up --build

down:
	sudo docker-compose -f $(COMPOSE_PATH) down

clean:
	sudo docker-compose -f $(COMPOSE_PATH) down
	sudo docker system prune -af

fclean:

	make clean
	sudo rm -rfd /home/rvrignon/data/wordpress
	sudo rm -rfd /home/rvrignon/data/mariadb
	mkdir /home/rvrignon/data/mariadb /home/rvrignon/data/wordpress

re:
	make fclean 
	make all