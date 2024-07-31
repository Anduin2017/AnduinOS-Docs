# Use AnduinOS to host service

AnduinOS is great for hosting services. Before starting, you need to make sure Docker is installed on your machine.

Please [Follow the Docker install instructions](../Applications/Development/Docker/Docker.md) to install Docker.

## Servicing with https

By default, all services in this document are served with http. If you want to serve with https, you need to install a reverse proxy server like [Caddy](../Applications/Development/Caddy/Caddy.md) or [Traefik](../Applications/Development/Traefik/Traefik.md).

## Servicing external customers behind NAT

Obviously, you can't expose your services to the internet directly if you are behind NAT. You need to use a reverse proxy server like [frp](.) to expose your services to the internet.
