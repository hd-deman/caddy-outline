FROM caddy:builder AS builder

RUN xcaddy build \
    --with github.com/iamd3vil/caddy_yaml_adapter \
    --with github.com/Jigsaw-Code/outline-ss-server/outlinecaddy

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "run", "--config", "/etc/caddy/config.yaml", "--adapter", "yaml"]

