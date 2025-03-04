ARG BASE_IMAGE=golang:latest

FROM ${BASE_IMAGE}

#
# Set-up user

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN addgroup --gid ${GROUP_ID} go \
	&& adduser --disabled-password --gecos '' --uid ${USER_ID} --gid ${GROUP_ID} go

RUN mkdir -p /go/pkg && chown -R ${USER_ID}:${GROUP_ID} /go/pkg

#
# Entrypoint

USER go
ENTRYPOINT [ "go" ]

#
# Sample compose file

# go:
#     image: caracolazul/golang:latest
#     user: go
#     volumes:
#       - go-modules:/go/pkg
#       - .:/go/src/${APP_NAME:-my-app}
#     working_dir: /go/src/${APP_NAME:-my-app}

# volumes:
# 	go-modules:
