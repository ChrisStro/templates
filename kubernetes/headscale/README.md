# headscale

An open source, self-hosted implementation of the Tailscale control server.

## Pros
- very low hardware requirements
- CLI is pretty easy
- support for the official Tailscale App
- Tailscale itself adds functionaltiy to the mobile app for headscale servers
- Tailscale client with many options
- simply works with reverse proxy
- Derb/relay server works via https
- native supported on some firewall distribution (PfSense,OpnSense,etc...)
- you could use a public DERB server list from Tailscale

## Cons
- single overlay network
- restriction must be configured via json or yaml file
- WebUI in "alpha" with a single user
- no custom STUN server list, Derb server also have to provide STUN (additional port)
- no authentication for Derb servers

[GitHub Page](https://github.com/juanfont/headscale)