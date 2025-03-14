# Container for compiling Go(lang)

Extends the official Go(lang) image for use in the scenario of building an app under development AND not using the container as a run-time. That is, it eases dealing with permissions.

Additionally, it sets the entrypoint to `go`.

**NB:** not tracking upstream, so "latest" for this image is NOT "golang:latest"

## Sample compose.yaml

``` yaml
go:
    image: caracolazul/golang:1.23
    user: go
    volumes:
      - go-modules:/go/pkg
      - go-cache:/home/go/.cache
      - .:/go/src/${APP_NAME:-my-app}
    working_dir: /go/src/${APP_NAME:-my-app}

volumes:
  go-modules:
  go-cache:
```

Note the persistent volumes to hold fetched packages and caches. Build time will be significantly higher without a persistent cache: do not overlook!

Note the `APP_NAME` environment variable. This will also be the name of the output library or executable.

Specifying the `user: go` is not necessary.

## Build Args

If your local user is not 1000, you probably want to build the image yourself to pass the build-arg's `USER_ID` and `GROUP_ID`.

`BASE_IMAGE` defaults to `golang:latest`.

