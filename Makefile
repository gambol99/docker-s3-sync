
NAME=s3-sync
AUTHOR=gambol99
REGISTRY=docker.io
VERSION=$(shell cat VERSION)

.PHONY: build test

default: build

build:
	sudo docker build -t ${REGISTRY}/${AUTHOR}/${NAME}:${VERSION} .

