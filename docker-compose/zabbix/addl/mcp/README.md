# Zabbix MCP compose

This compose file runs the official
[`zabbix/zabbix-mcp-server`](https://hub.docker.com/r/zabbix/zabbix-mcp-server)
as a standalone stack under `addl/mcp`.

## Configuration

Run all commands from `docker-compose/zabbix`.

1. Configure `PROXY_NETWORK` in the base `.env` to match the external Traefik network.
2. Set `ZBX_MCP_PUBLIC_HOSTNAME` in `addl/mcp/.env` for the Traefik router.

Other MCP settings use the defaults in `compose.yaml` and are deliberately not duplicated in
`.env`. Override them through the environment when invoking Compose, or through a separate local
env file. For example, set `ZBX_FRONTEND_URL` to a reachable Zabbix API URL ending in
`api_jsonrpc.php` if the default URL is not applicable.

## Start

Run from `docker-compose/zabbix` and load the base + MCP env files:

```sh
docker compose --env-file .env --env-file addl/mcp/.env \
  -f addl/mcp/compose.yaml config --quiet

docker compose --env-file .env --env-file addl/mcp/.env \
  -f addl/mcp/compose.yaml up -d
```

The MCP service does not publish a host port. Access it through the Traefik router:

- `https://${ZBX_MCP_PUBLIC_HOSTNAME}/mcp`

Each MCP request must include a valid Zabbix API token as bearer token:

```http
Authorization: Bearer <ZABBIX_API_TOKEN>
```

## Security notes

- The compose file includes Traefik labels (`traefik.enable=true`) and joins `proxy_network`.
- Set `ZBX_MCP_PUBLIC_HOSTNAME` to a dedicated hostname and secure it in Traefik as needed.
- No host port is published; the MCP service is reachable through its Traefik router on `proxy_network`.
- `ZBX_ALLOWEDIP` defaults to `0.0.0.0/0` so Traefik can reach the MCP service. Keep the container
  off directly exposed networks; if direct access is required, override this with trusted source CIDRs.
- `ZBX_IGNOREURLCERTERRORS=true` is only suitable for testing.

Use HTTPS via Traefik for client access.

`ZBX_FRONTEND_URL` must point to a reachable Zabbix API endpoint (for example your base Zabbix stack URL ending in `api_jsonrpc.php`).
