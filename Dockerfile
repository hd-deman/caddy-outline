FROM golang:1.25-alpine AS builder

RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

WORKDIR /build
RUN xcaddy build \
  --with github.com/iamd3vil/caddy_yaml_adapter \
  --with github.com/mholt/caddy-l4 \
  --with github.com/Jigsaw-Code/outline-ss-server/outlinecaddy

FROM alpine:3.20

COPY --from=builder /build/caddy /usr/local/bin/caddy

ENTRYPOINT ["caddy"]
