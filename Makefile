# Version will extract the current version of Conduit based on
# the latest git tag and commit. If the repository contains any
# changes the version will have the suffix "-dirty", it will
# ignore any untracked files though to ensure Docker builds have
# the correct version.
VERSION=`git describe --tags --dirty`
GO_VERSION_CHECK=`./scripts/check-go-version.sh`

# The build target should stay at the top since we want it to be the default target.
.PHONY: build
build: check-go-version
	go build -ldflags "-X 'github.com/conduitio/conduit/pkg/conduit.version=${VERSION}'" -o conduit main.go
	@echo "\nBuild complete. Enjoy using Conduit!"
	@echo "Get started by running:"
	@echo " ./conduit run"

.PHONY: docker-build
docker-build:
	docker build . -t custom-conduit-local:latest

.PHONY: run
run:
	go run main.go

.PHONY: check-go-version
check-go-version:
	@if [ "${GO_VERSION_CHECK}" != "" ]; then\
		echo "${GO_VERSION_CHECK}";\
		exit 1;\
	fi
