# build
ARG GO_VERSION=1.18

FROM golang:${GO_VERSION}-alpine AS builder

RUN apk update && apk add alpine-sdk git && rm -rf /var/cache/apk/*

WORKDIR /app
COPY go.mod .
COPY go.sum .
# RUN ls -lah
RUN go mod download

COPY . .
RUN go test ./...
RUN go build -o main main.go

# run
FROM alpine:3.17
ARG port="8080"
WORKDIR /app
ENV PORT ${port}
COPY --from=builder /app .

EXPOSE ${port}

ENTRYPOINT /app/main