ARG version=2.8
ARG buildargs=--with github.com/caddy-dns/cloudflare
FROM caddy-$version-builder-alpine as builder

RUN xcaddy build $buildargs

FROM caddy:$version

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
