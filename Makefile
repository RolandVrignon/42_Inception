# Variables
COMPOSE = docker-compose
PROJECT_NAME = my_project

# Default target
all: up

# Docker Compose targets
up:
    $(COMPOSE) up -d

down:
    $(COMPOSE) down

# Clean target
clean:
    $(COMPOSE) down --volumes --remove-orphans
    docker network rm $(PROJECT_NAME)_inception
