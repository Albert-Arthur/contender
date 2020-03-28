FROM golang:1.14-alpine AS base

WORKDIR /go/contender

COPY go.mod go.sum ./
RUN go mod download

COPY . .


FROM base as dev

RUN ["go", "get", "github.com/githubnemo/CompileDaemon"]

ENTRYPOINT CompileDaemon -build="go build -o contender main.go" -command="./contender"


FROM base as build

ENV GO111MODULE="on" \
    CGO_ENABLED=0 \
    GOOS=linux

RUN go build -o contender main.go


FROM alpine:latest as prod

RUN apk --no-cache add ca-certificates

RUN mkdir -p /go/contender
WORKDIR /go/contender

COPY --from=build /go/contender .

CMD ["./contender"]
