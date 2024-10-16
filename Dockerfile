ARG version=2.8
ARG buildargs=--with github.com/caddy-dns/cloudflare --with github.com/greenpau/caddy-security --with github.com/mholt/caddy-l4 --with github.com/mholt/caddy-ratelimit --with github.com/caddy-plugins/nobots
FROM caddy:${version}-builder-alpine as builder

RUN xcaddy build $buildargs

FROM caddy:$version

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
