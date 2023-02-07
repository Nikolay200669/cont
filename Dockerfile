# build
ARG GO_VERSION=1.18

FROM golang:${GO_VERSION}-alpine AS builder

RUN apk update && apk add alpine-sdk git && rm -rf /var/cache/apk/*

WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN ls -lah
RUN go mod download

COPY . .
RUN go build -o main main.go

# run
FROM alpine:3.17
WORKDIR /app
RUN ls -alh
COPY --from=builder /app .

EXPOSE 8080

ENTRYPOINT /app/main