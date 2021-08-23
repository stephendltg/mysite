#!Make
BINARY_NAME=$(shell node -p "require('./package.json').name")
VERSION := $(shell node -p "require('./package.json').version")
DESCRIPTION := $(shell node -p "require('./package.json').description")
HOMEPAGE := $(shell node -p "require('./package.json').homepage")
AUTHOR=stephendltg
DENO=1.13.0
HUGO=v0.87.0

install: 
	@echo "Installing project ${BINARY_NAME}..."
	curl -fsSL https://deno.land/x/install/install.sh | sh
	deno upgrade --version ${DENO}

server:
	hugo server -D

build: 
	hugo -D

theme:
	git submodule add https://github.com/luizdepra/hugo-coder.git themes/hugo-coder

env:
	@echo "Binary name: $(BINARY_NAME)"
	@echo "Version: $(VERSION)"
	@echo "Description: $(DESCRIPTION)"
	@echo "Homepage: $(HOMEPAGE)"
	@echo "Author: $(AUTHOR)"
	@echo "Hugo: $(HUGO)"
	@echo "Deno: ${DENO}"