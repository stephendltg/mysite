#!Make

HUGO=v0.87.0

server:
	hugo server -D

build: 
	hugo -D

theme:
	git submodule add https://github.com/luizdepra/hugo-coder.git themes/hugo-coder