FROM caddy:builder AS builder

RUN xcaddy build \
    --with github.com/iamd3vil/caddy_yaml_adapter \
    --with github.com/Jigsaw-Code/outline-ss-server/outlinecaddy

FROM caddy:alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Ensure we can bind low ports if needed (though 8080 is fine)
# and update certs
RUN apk add --no-cache ca-certificates libcap && \
    setcap cap_net_bind_service=+ep /usr/bin/caddy

# Default to running with a JSON config, which is native and safer
CMD ["caddy", "run", "--config", "/etc/caddy/config.json"]
