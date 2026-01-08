# Caddy with Outline Support

This project builds a custom Caddy image with the Outline (Shadowsocks) module and YAML adapter, enabling Caddy to serve as a frontend for Outline servers with automatic HTTPS.

## Prerequisites

- Docker and Docker Compose
- A domain name pointing to your server's IP address (A record for IPv4, AAAA for IPv6)

## Setup

1. **Configure `config.yaml`**:
   - Replace `example.com` with your actual domain name.
   - Replace `/secret-tcp-path` and `/secret-udp-path` with long, random strings (e.g., generated via `openssl rand -hex 16`).
   - Replace `REPLACE_WITH_SECRET` with a Shadowsocks secret. You can generate one using:
     ```bash
     openssl rand -base64 16
     ```

2. **Build and Run**:
   ```bash
   docker-compose up -d --build
   ```

3. **Verify**:
   Check the logs to ensure Caddy obtained a certificate:
   ```bash
   docker-compose logs -f
   ```

## Client Connection

To connect using the Outline client or other Shadowsocks clients, you will need to construct a dynamic access key (YAML) or use the specific client configuration for Shadowsocks over Websockets.

Example `dynamic-key.yaml` for Outline:
```yaml
transport:
  $type: tcpudp
  tcp:
    $type: shadowsocks
    endpoint:
      $type: websocket
      url: wss://example.com/secret-tcp-path
    cipher: chacha20-ietf-poly1305
    secret: YOUR_SECRET
  udp:
    $type: shadowsocks
    endpoint:
      $type: websocket
      url: wss://example.com/secret-udp-path
    cipher: chacha20-ietf-poly1305
    secret: YOUR_SECRET
```

