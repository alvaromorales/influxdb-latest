#!/usr/bin/env bash

cd $GOPATH/src/github.com/influxdb/influxdb
VERSION=$(git describe --tags $(git rev-list --tags --max-count=1) | sed 's/^.//')
COMMIT=$(git rev-parse --verify HEAD)

cd $GOPATH/src/github.com/influxdb
go get -u -f -t ./...
go build -ldflags="-X main.version $VERSION -X main.commit $COMMIT" ./...
go install ./...
