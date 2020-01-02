.PHONY: help build dev test test-env push

# Docker image name and tag
OWNER := rholbrook
BASE_STACKS := minimal-gpu-notebook \
	r-gpu-notebook \
	python-gpu-notebook
BASE_IMAGES := $(BASE_STACKS)
TAG ?= latest
# Shell that make should use
SHELL := bash

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z0-9_%/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build/%: DARGS?=
build/%: ## Make the latest build of the image
	docker build $(DARGS) --rm --force-rm -t $(OWNER)/$(notdir $@):$(TAG) ./$(notdir $@)

build-base: $(foreach I, $(BASE_IMAGES), build/$(I)) ## Make the minimal, R, and Python stacks

build/datascience-gpu-notebook: DARGS?=
build/datascience-gpu-notebook: # Make a stack containing everything
	docker build $(DARGS) --rm --force-rm --build-arg BASE_CONTAINER=$(OWNER)/python-gpu-notebook -t $(OWNER)/datascience-gpu-notebook:$(TAG) ./r-gpu-notebook

push/%: ## Push the image to Docker Hub
	docker push $(OWNER)/$(notdir $@):$(TAG)

push-base: $(foreach I, $(BASE_IMAGES), push/$(I))

test/%: ## Run tests against a stack
	@TEST_IMAGE="$(OWNER)/$(notdir $@)" pytest tests

test-base: $(foreach I, $(BASE_IMAGES), test/$(I))

test-env: ## Make a test environment by installing test dependencies with pip
	pip install -r requirements-test.txt

dev/%: ARGS?=
dev/%: DARGS?=
dev/%: PORT?=8888
dev/%: ## Run a foreground container for a stack
	docker run -it --rm -p $(PORT):8888 $(DARGS) $(OWNER)/$(notdir $@) $(ARGS)
