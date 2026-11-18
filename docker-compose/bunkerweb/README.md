# BunkerWeb

BunkerWeb is an open-source and cloud-native Web Application Firewall (WAF) and
reverse proxy, based on NGINX. This stack runs the full Docker autoconf
integration: BunkerWeb instance + scheduler + web UI + autoconf (via a
docker-socket-proxy) + MariaDB + Redis, in multisite mode.

[GitHub Page](https://github.com/bunkerity/bunkerweb)

Notes:
- BunkerWeb is the edge proxy here: it exposes ports 80/443 directly (like the
  zoraxy stack), so stop any other proxy holding those ports first.
- After first start, open `https://<server-ip-or-fqdn>/setup` and run the setup
  wizard (admin account, UI server name, Let's Encrypt).
- Protect a container by attaching it to the `bw-services` network and adding
  labels, e.g.:
  ```yaml
  labels:
    - "bunkerweb.SERVER_NAME=app.example.com"
    - "bunkerweb.USE_REVERSE_PROXY=yes"
    - "bunkerweb.REVERSE_PROXY_URL=/"
    - "bunkerweb.REVERSE_PROXY_HOST=http://myapp:8080"
  ```
- Set `MYSQL_PASSWORD` (and optionally `API_TOKEN`) in `.env` before starting.
- The bw-universe network subnet (10.20.30.0/24) must stay in sync with
  `API_WHITELIST_IP` in compose.yaml.
- Under **podman** set `DNS_RESOLVERS` in `.env` to the bw-universe gateway IP
  (e.g. `10.20.30.1`) - the default `127.0.0.11` is Docker's embedded DNS and
  causes `recv() failed (111: Connection refused) while resolving` log spam.

## Web UI behind Traefik

To reach the BunkerWeb web UI through your Traefik proxy instead of only via
BunkerWeb itself, use the override in `addl/`:

```bash
docker compose -f compose.yaml -f addl/compose.traefik.yaml up -d
```

The UI is then reachable at `https://$PUBLIC_HOSTNAME` via Traefik (port 7000
of bw-ui is never exposed directly).
