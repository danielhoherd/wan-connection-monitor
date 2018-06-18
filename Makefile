.DEFAULT_GOAL := help

.PHONY: help
help: ## Print Makefile help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'


SUDO          = $(shell which sudo)
IMAGE_NAME   ?= wan-connection-logger
NAME         ?= $(IMAGE_NAME)
NO_CACHE     ?= false
GIT_BRANCH    = $(shell git rev-parse --abbrev-ref HEAD)
GIT_SHA_SHORT = $(shell if [ ! -z "`git status --porcelain`" ] ; then echo "DIRTY" ; else git rev-parse --short HEAD ; fi)
GIT_SHA_LONG  = $(shell if [ ! -z "`git status --porcelain`" ] ; then echo "DIRTY" ; else git rev-parse HEAD ; fi)
BUILD_TIME    = $(shell date '+%s')
RESTART      ?= always

.PHONY: all
all: build

.PHONY: build
build: ## Build the Dockerfile in PWD
	docker build --no-cache=${NO_CACHE} \
		-t ${IMAGE_NAME}:latest \
		-t ${IMAGE_NAME}:${GIT_BRANCH}-${GIT_SHA_SHORT} \
		-t ${IMAGE_NAME}:${GIT_BRANCH}-${GIT_SHA_LONG} \
		-t ${IMAGE_NAME}:${BUILD_TIME} \
		.

.PHONY: install-hooks
install-hooks: ## Install git hooks
	pip3 install --user --upgrade pre-commit || \
	pip install --user --upgrade pre-commit
	pre-commit install -f --install-hooks

.PHONY: run
run: build ## Build and run the Dockerfile in pwd
	docker run \
		-d \
		--restart=$(RESTART) \
		--name=$(NAME) \
		--net=host \
		--mount type=bind,src="/etc/localtime",dst="/etc/localtime",readonly \
		--mount type=bind,src="$(PWD)",dst="/data" \
		$(IMAGE_NAME)

.PHONY: test
test: ## Test that the container functions
	docker run --rm -it $(IMAGE_NAME) fping localhost

.PHONY: stop
stop: ## Delete deployed container
	-docker stop $(NAME)

.PHONY: rm
rm: stop ## Delete deployed container
	-docker rm --force $(NAME)

.PHONY: logs
logs: ## View the last 30 minutes of log entries
	docker logs --since 30m $(NAME)

.PHONY: bounce
bounce: build rm run ## Rebuild, rm and run the Dockerfile
