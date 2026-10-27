# Zabbix MCP override

This override adds the official
[`zabbix/zabbix-mcp-server`](https://hub.docker.com/r/zabbix/zabbix-mcp-server)
container to the existing Zabbix stack.

The base stack remains unchanged unless you explicitly load this override file.

## Configuration

Run all commands from `docker-compose/zabbix`.

1. Configure the base `.env` as usual (hostname, proxy network, database password).
2. Edit `addl/mcp/.env`:
   - `ZBX_FRONTEND_URL`: Zabbix API URL ending in `api_jsonrpc.php`.
   - `ZBX_ALLOWEDIP`: allowed source IPs/CIDRs for MCP clients.
   - `ZBX_MCP_PORT`: local host loopback port (default `8443`).
   - `ZBX_MCP_PUBLIC_HOSTNAME`: hostname used by Traefik for the MCP router.
   - optional runtime tuning (`ZBX_TIMEOUT`, `ZBX_DEBUGLEVEL`, ...).

The checked-in `addl/mcp/.env` is a template. Keep environment-specific values local.

## Start

Load both env files and both compose files explicitly:

```sh
docker compose --env-file .env --env-file addl/mcp/.env \
  -f compose.yaml -f addl/mcp/compose.override.yaml config --quiet

docker compose --env-file .env --env-file addl/mcp/.env \
  -f compose.yaml -f addl/mcp/compose.override.yaml up -d
```

The MCP endpoint is available on:

- `http://127.0.0.1:${ZBX_MCP_PORT:-8443}/mcp`

Each MCP request must include a valid Zabbix API token as bearer token:

```http
Authorization: Bearer <ZABBIX_API_TOKEN>
```

## Security notes

- The override always includes Traefik labels (`traefik.enable=true`) and joins `proxy_network`.
- Set `ZBX_MCP_PUBLIC_HOSTNAME` to a dedicated hostname and secure it in Traefik as needed.
- The override still publishes the MCP port only on IPv4 loopback (`127.0.0.1`) by default.
- Keep `ZBX_ALLOWEDIP` restricted to trusted client networks.
- `ZBX_IGNOREURLCERTERRORS=true` is only suitable for testing.

For remote usage, prefer HTTPS via Traefik or tunnel the local port over SSH.
