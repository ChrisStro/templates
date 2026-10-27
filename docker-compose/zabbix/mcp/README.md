# Zabbix MCP override

This override adds the official
[`zabbix/zabbix-mcp-server`](https://hub.docker.com/r/zabbix/zabbix-mcp-server)
container to the existing Zabbix stack.

The base stack remains unchanged unless you explicitly load this override file.

## Configuration

Run all commands from `docker-compose/zabbix`.

1. Configure the base `.env` as usual (hostname, proxy network, database password).
2. Edit `mcp/.env`:
   - `ZBX_FRONTEND_URL`: Zabbix API URL ending in `api_jsonrpc.php`.
   - `ZBX_ALLOWEDIP`: allowed source IPs/CIDRs for MCP clients.
   - `ZBX_MCP_PORT`: local host loopback port (default `8443`).
   - optional runtime tuning (`ZBX_TIMEOUT`, `ZBX_DEBUGLEVEL`, ...).

The checked-in `mcp/.env` is a template. Keep environment-specific values local.

## Start

Load both env files and both compose files explicitly:

```sh
docker compose --env-file .env --env-file mcp/.env \
  -f compose.yaml -f mcp/compose.override.yaml config --quiet

docker compose --env-file .env --env-file mcp/.env \
  -f compose.yaml -f mcp/compose.override.yaml up -d
```

The MCP endpoint is available on:

- `http://127.0.0.1:${ZBX_MCP_PORT:-8443}/mcp`

Each MCP request must include a valid Zabbix API token as bearer token:

```http
Authorization: Bearer <ZABBIX_API_TOKEN>
```

## Security notes

- The override publishes the MCP port only on IPv4 loopback (`127.0.0.1`) by default.
- `ZBX_ALLOWEDIP` should still be restricted, especially if you later expose the service.
- `ZBX_IGNOREURLCERTERRORS=true` is only suitable for testing.

For remote usage, tunnel the local port over SSH instead of exposing it directly.
