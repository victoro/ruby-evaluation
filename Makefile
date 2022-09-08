DOCKER_COMPOSE=docker-compose -f docker-compose.yml
TERM_LINES=$(shell tput lines)
TERM_COLS=$(shell tput cols)

.PHONY: all build ssh logs install

ssh:
	$(DOCKER_COMPOSE) exec drkiq env TERM=xterm /bin/bash -c "stty cols $(TERM_COLS) rows $(TERM_LINES) && /bin/bash"

# install:

up:
	$(DOCKER_COMPOSE) up -d --remove-orphans

pull-up:
	$(DOCKER_COMPOSE) pull && $(DOCKER_COMPOSE) up -d --build

stop:
	$(DOCKER_COMPOSE) stop

down:
	$(MAKE) stop

build:
	$(DOCKER_COMPOSE) build
	$(DOCKER_COMPOSE) up -d

logs:
	$(DOCKER_COMPOSE) logs --follow


