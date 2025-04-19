IMAGE_NAME ?= caracolazul/golang-vscode

# first will be used for :latest
TAGS ?= \
	1.24 \
	1.23

ifdef NO_CACHE
NO_CACHE=--no-cache
endif

build:
	@for version in ${TAGS}; do \
		docker build ${NO_CACHE} \
			--build-arg GO_VERSION=$$version -t ${IMAGE_NAME}:$$version \
			-f Containerfile . ; \
	done
	docker tag ${IMAGE_NAME}:$(firstword ${TAGS}) ${IMAGE_NAME}:latest

push:
	@for version in ${TAGS} latest; do \
		docker push ${IMAGE_NAME}:$$version; \
	done