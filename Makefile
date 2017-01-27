SHELL  := /bin/bash

list:
	sh -c "echo; $(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep -v 'Makefile'| sort"

build-rutorrent:
	cd docker/rutorrent; make build

build-deluge:
	cd docker/deluge; make build

build-frontend:
	cd docker/frontend; make build

build-filebot:
	cd docker/filebot; make build

build-plexpy:
	cd docker/plexpy; make build

up:
	docker-compose up -d

start:
	docker-compose start

down:
	docker-compose down

stop:
	docker-compose stop

state:
	docker-compose ps

rebuild:
	docker-compose stop
	docker-compose rm --force app
	docker-compose build --no-cache
	docker-compose up -d
