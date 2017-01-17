SHELL  := /bin/bash


build-rutorrent:
	cd docker/rutorrent; make build

build-deluge:
	cd docker/deluge; make build

build-frontend:
	cd docker/frontend; make build

build-filebot:
	cd docker/filebot; make build
