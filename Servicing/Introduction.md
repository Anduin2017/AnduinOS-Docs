# Use AnduinOS to host service

AnduinOS is great for hosting services. Before starting, you need to make sure Docker is installed on your machine.

Please [Follow the Docker install instructions](../Applications/Development/Docker/Docker.md) to install Docker.

!!! note "Start exploring now!"

    To get started, pick the app from the menu on the left!

## Servicing with https

By default, all services in this document are served with http. If you want to serve with https, you need to install a reverse proxy server like [Caddy](../Applications/Development/Caddy/Caddy.md) or [Traefik](../Applications/Development/Traefik/Traefik.md).

## Servicing external customers behind NAT

Obviously, you can't expose your services to the internet directly if you are behind NAT. You need to use a reverse proxy server like [frp](.) to expose your services to the internet.

## Bought a server from an external provider? Set it up!

If you have bought a server from an external provider, usually it's not following the Linux authentication best practices. You need to set it up properly before hosting services on it. Please refer to the [Linux server setup guide](./Linux.md) for more information.
