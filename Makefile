#!Make
BINARY_NAME=$(shell node -p "require('./package.json').name")
VERSION := $(shell node -p "require('./package.json').version")
DESCRIPTION := $(shell node -p "require('./package.json').description")
HOMEPAGE := $(shell node -p "require('./package.json').homepage")
AUTHOR=stephendltg
DENO=1.13.0
HUGO=v0.87.0
NODE=v14.16.1
NVM=v0.38.0

install: 
	@echo "Installing project ${BINARY_NAME}..."
	. ${NVM_DIR}/nvm.sh && nvm install ${NODE} 
	nvm use ${NODE}
	npm install
	curl -fsSL https://deno.land/x/install/install.sh | sh
	deno upgrade --version ${DENO}

theme:
	git submodule add https://github.com/luizdepra/hugo-coder.git themes/hugo-coder

nvm:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM}/install.sh | bash

env:
	@echo "Binary name: $(BINARY_NAME)"
	@echo "Version: $(VERSION)"
	@echo "Description: $(DESCRIPTION)"
	@echo "Homepage: $(HOMEPAGE)"
	@echo "Author: $(AUTHOR)"
	@echo "Hugo: $(HUGO)"
	@echo "Deno: ${DENO}"
	@echo "Nodejs: ${NODE}"
	@echo "Nvm: ${NVM}"