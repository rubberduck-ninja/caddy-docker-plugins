ARG version=2.8
FROM caddy:${version}-builder-alpine AS builder

RUN xcaddy build \
  --with github.com/caddy-dns/cloudflare \
  --with github.com/greenpau/caddy-security \
  --with github.com/mholt/caddy-l4 \
  --with github.com/mholt/caddy-ratelimit \
  --with github.com/ggicci/caddy-jwt

FROM caddy:$version
EXPOSE 8080 8443
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} CUSTOM_BUILD="" WEBUI_PORTS="8080/tcp,8080/udp,8443/tcp,8443/udp"
ENV CONFIG_FILE="/config/Caddyfile"
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
CMD caddy run --config $CONFIG_FILE
