#!Make

HUGO=v0.87.0

server:
	hugo server -D

build: 
	hugo -D