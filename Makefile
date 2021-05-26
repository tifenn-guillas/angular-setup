#UID := $(id -u)
#GID := $(id -g)

UID := 1000
GID := 1000

list:
	@echo ""
	@echo "Useful targets:"
	@echo ""
	@echo "  install      > install node modules dependencies (node_modules)"
	@echo "  start        > run a dev server"
	@echo "  stop         > stop the dev server"
	@echo "  restart      > restart the dev server"
	@echo "  status       > display container status"
	@echo "  build        > generate the angular dist application (html, css, js)"
	@echo "  logs         > display container logs"
	@echo "  shell        > shell into container"
	@echo ""

install:
	@docker build -t angular-setup .
	@docker run --init -it --rm --user $(UID):$(GID) \
	-v $(CURDIR):/project \
	-w /project angular-setup npm install

start:
	@docker build -t angular-setup . && docker run --init -it --rm --user $(UID):$(GID) \
	--name angular-setup \
	-p 4200:4200 \
	-v $(CURDIR):/project -d \
	-w /project angular-setup ng serve --host=0.0.0.0 --disable-host-check --port 4200

stop:
	@docker stop angular-setup

restart: stop start

status:
	@docker ps -f name=angular-setup

build:
	@docker build -t angular-setup . && docker run --init -it --rm --user $(UID):$(GID) \
	-v $(CURDIR):/project \
	-w /project angular-setup ng build --prod

logs:
	@docker logs -f -t angular-setup

shell:
	@docker exec -ti angular-setup bash
