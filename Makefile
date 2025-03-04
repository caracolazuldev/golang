
GO_VERSIONS := \
	1.24 \
	1.23 \
	1.22 

build:
	docker build --no-cache --build-arg BASE_IMAGE=golang:latest -t caracolazul/golang:latest -f Containerfile .;
	@for version in $(GO_VERSIONS); do \
		docker build --build-arg BASE_IMAGE=golang:$$version -t caracolazul/golang:$$version -f Containerfile .; \
	done

push:
	@for version in $(GO_VERSIONS); do \
		docker push caracolazul/golang:$$version; \
	done