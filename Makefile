IMAGE=angular
APP=angular-setup
UID := 1000
GID := 1000

.DEFAULT_GOAL := help

help:
	@echo ""
	@echo "Useful targets:"
	@echo ""
	@echo "  install      > Install project"
	@echo "  node     	  > Shell into Node container"
	@echo "  status       > Display container status"
	@echo "  start    	  > Run the application in development mode"
	@echo "  stop         > Stop the application"
	@echo "  restart      > Restart the application in development mode"
	@echo "  logs         > Display application logs"
	@echo "  build        > Build the application for production"
	@echo ""

install:
	docker build -t $(IMAGE) .
	docker run --user $(UID):$(GID) --rm -it --volume="$(CURDIR):/src" $(IMAGE) bash ./init.sh

node:
	docker run --rm --volume="$(CURDIR):/src" -it $(IMAGE) bash

status:
	docker ps -f name=$(APP)

start:
	docker run --name $(APP) --rm --volume="$(PWD):/src" --publish 80:80 --workdir /src -it -d $(IMAGE) ng serve --disable-host-check --host=0.0.0.0 --port 80

stop:
	docker stop $(APP)

restart: stop start

logs:
	docker logs -f -t $(APP)

build:
	docker run --init -it --rm --volume="$(PWD):/src" --workdir /src $(IMAGE) ng build
