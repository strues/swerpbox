SHELL  := /bin/bash

RUTORRENT_IMAGE   = swerpbox/rutorrent
SONARR_IMAGE      = swerpbox/sonarr
DELUGE_IMAGE      = swerpbox/deluge
PLEXPY_IMAGE      = swerpbox/plexpy
FRONTEND_IMAGE    = swerpbox/frontend
RESILIO_IMAGE     = swerpbox/resilio-sync
UBUNTU_IMAGE      = swerpbox/ubuntu-base
ALPINE_IMAGE      = swerpbox/alpine-base
PLEX_IMAGE        = plexinc/pms-docker

NETWORK_NAME=swerpbox
NETWORK_CREATE_CMD=docker network create $(NETWORK_NAME)

_configure_network: ## creates the swerpbox network
	@docker network inspect $(NETWORK_NAME) >/dev/null 2>&1 || $(NETWORK_CREATE_CMD)

_remove_network: ## removes the swerpbox network
	docker network rm $(NETWORK_NAME)

build-alpine: ## builds the alpine base image from scratch
	cd docker/base/alpine; make build
pull-alpine: ## pulls alpine base image from docker hub
    docker build -t $(ALPINE_IMAGE) --pull=true --no-cache=true sb-alpine-base

build-ubuntu: ## builds the ubuntu base image from scratch
	cd docker/base/ubuntu; make build
pull-ubuntu: ## pulls ubuntu base image from docker hub
    docker build -t $(UBUNTU_IMAGE) --pull=true --no-cache=true sb-ubuntu-base

build-rutorrent: ## builds the rutorrent image from scratch
	cd docker/rutorrent; make build
pull-rutorrent: ## pulls rutorrent image from docker hub
    docker build -t $(RUTORRENT_IMAGE) --pull=true --no-cache=true sb-rutorrent

build-deluge: ## builds the deluge image from scratch
	cd docker/deluge; make build
pull-deluge: ## pulls deluge image from docker hub
    docker build -t $(DELUGE_IMAGE) --pull=true --no-cache=true sb-deluge

build-frontend: ## builds the frontend image from scratch
	cd docker/frontend; make build
pull-frontend: ## pulls frontend image from docker hub
    docker build -t $(FRONTEND_IMAGE) --pull=true --no-cache=true sb-frontend

build-plexpy: ## builds the plexpy image from scratch
	cd docker/plexpy; make build
pull-plexpy: ## pulls plexpy image from docker hub
    docker build -t $(PLEXPY_IMAGE) --pull=true --no-cache=true sb-plexpy

build-sonarr: ## builds the sonarr image from scratch
	cd docker/sonarr; make build
pull-sonarr: ## pulls sonarr image from docker hub
    docker build -t $(SONARR_IMAGE) --pull=true --no-cache=true sb-sonarr

build-resilio: ## builds the resilio-sync image from scratch
	cd docker/resilio-sync; make build
pull-resilio: ## pulls resilio-sync image from docker hub
    docker build -t $(RESILIO_IMAGE) --pull=true --no-cache=true sb-resilio

start: ## run all containers in docker-compose.yml
	docker-compose up -d

down: ## stop all running containers and remove network
	docker-compose down

stop: ## stop all running containers
	docker-compose stop

status: ## display information for running containers
	docker-compose ps

rebuild:
	docker-compose down
	docker-compose build --no-cache
	docker-compose up -d

# helpers
help: ## print list of tasks and descriptions
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

.PHONY: all
