SHELL = /bin/bash
IMAGE_NAME ?= dubizzledotcom/scala-stream-collector
IMAGE_VERSION ?= 0.0.2

.PHONY: docker

docker:
		docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .
