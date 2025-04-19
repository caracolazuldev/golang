# Go(lang) Development Containers

The **caracolazul/golang** image extends the official Go(lang) image for use in the scenario of building an app under development AND not using the container as a run-time. That is, it eases dealing with permissions when a build artifacts are used outside of the build container.

*"Use the source"* to see what go development tool packages are included in the image.

Additionally, it sets the entrypoint to `go` to so you can name your compose-service "go" and not repeat yourself: `docker compose run --rm go test`, or if you [use make like I do](https://github.com/caracolazuldev/make-do), `make run go test`.

The **caracolazul/golang-vscode image** adds vscode-server so that it can be used as a vs-code "dev container". This is especially useful if you want to work off-line. 

*"Use the source"* to see what vs code extensions are pre-installed.

**NB:** not tracking upstream, so "latest" for this image is NOT "golang:latest"

## Building images

If your local user is not 1000, you probably want to build the image yourself to pass the build-arg's `USER_ID` and `GROUP_ID`.

`BASE_IMAGE` defaults to `golang:latest`. You may use `GO_VERSION` instead of providing a fully-qualified base-image.

A `Makefile` is included for each image, which can be used to build and tag images for each version in `TAGS` (whitespace separated list). To save precious keystrokes, `make -C golang && make -C vscode` to run the default target (`build`) in each folder.

To publish your own images, override `IMAGE_NAME` and use the make target, `push`.


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

## Tips for using VS Code Dev Containers

**NB: This doesn't work**

> Possible solution:
> The docs for Dev Containers states that the server and client must match version exactly. 
> Apparently, to enforce this, it installs itself inside the container to a path that contains the commit-ID (hash).
> So, either, we can create an image from the container post-install, or we can look-up the commit id in an initialized container, and update the Containerfile to install the server (and extensions) in the correct directory. 
> Hmmm... what if we just create a managed volume...

I was dense and didn't realize that vscode is not smart enough to start the dev-container on it's own. Be sure your container is started.

As of this writing, when VS Code generates the dev container configs, you need to mamually complete the configuration, or you will get an error the next time you try to connect to the dev container.

Chiefly: be sure to set 
 * the mount target in `.devcontainer/docker-compose.yml` for your source
 * `"workspaceFolder"` in `devcontainer.json` to the mount target above


