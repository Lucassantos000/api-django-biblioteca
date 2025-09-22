include .env
export $(shell sed 's/=.*//' .env)
export COMPOSE_PROJECT_NAME=api-biblioteca
export DATA=$(shell date '+%F+%H-%M-%S')

COMPOSE=docker compose -f docker/docker-compose.yml
CAMINHO_DOCKERFILE= ./docker/dockerfile
API_IMAGE=api-django-biblioteca

build:
	@docker build -t $(API_IMAGE) -f $(CAMINHO_DOCKERFILE) .

build-no-cache:
	@docker build --no-cache -t $(API_IMAGE) -f $(CAMINHO_DOCKERFILE) .

up-dev:
	$(COMPOSE) up -d

down-dev:
	$(COMPOSE) down

start-db:
	$(COMPOSE) up -d db

stop-db:
	$(COMPOSE) down db

start-redis:
	$(COMPOSE) up -d redis

stop-redis:
	$(COMPOSE) down redis

start-pgadmin:
	$(COMPOSE) up -d pgadmin

stop-pgadmin:
	$(COMPOSE) down pgadmin


runserver start-api:
	$(COMPOSE) up $(API_IMAGE)
#	$(COMPOSE) up celery api-django-biblioteca

stop-api:
	$(COMPOSE) down api-django-biblioteca

bash-api:
	$(COMPOSE) exec api-django-biblioteca bash

bash-db:
	$(COMPOSE) exec db bash

bash-redis:
	$(COMPOSE) exec redis bash


#uv
freeze:
	uv pip freeze > requirements.txt

#logs

logs:
	$(COMPOSE) logs -f

# manage

createsuperuser:
	$(COMPOSE) exec api-django-biblioteca python manage.py createsuperuser