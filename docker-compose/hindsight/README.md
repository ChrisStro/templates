# Hindsight

Hindsight is a memory layer for AI applications with an API server and a control-plane web UI.

[GitHub Page](https://github.com/vectorize-io/hindsight)

## Notes

- This stack uses a dedicated PostgreSQL container with pgvector (`pgvector/pgvector`) instead of embedded pg0 storage.
- Traefik exposes two hostnames:
  - `HINDSIGHT_API_PUBLIC_HOSTNAME` → API on container port `8888`
  - `HINDSIGHT_UI_PUBLIC_HOSTNAME` → Control Plane UI on container port `9999`
- No host ports are published directly.

## Setup

1. Edit `.env`:
   - Set `PROXY_NETWORK` to your external Traefik docker network.
   - Set both public hostnames.
   - Set `HINDSIGHT_API_LLM_API_KEY` to a valid provider key.
   - Set `HINDSIGHT_DB_PASSWORD` for the PostgreSQL container.
2. Optional DB variables (defaults shown):
   - `HINDSIGHT_DB_USER` (`hindsight_user`)
   - `HINDSIGHT_DB_NAME` (`hindsight_db`)
   - `HINDSIGHT_DB_VERSION` (`18`)
3. Start the stack:

```sh
docker compose up -d
```

4. Access via Traefik:
   - API: `https://${HINDSIGHT_API_PUBLIC_HOSTNAME}`
   - UI: `https://${HINDSIGHT_UI_PUBLIC_HOSTNAME}`

## Migration note

This change does not automatically migrate existing data from the old `.pg0` volume.
If you already ran the previous stack, migrate data manually before switching in production.
