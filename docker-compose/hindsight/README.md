# Hindsight

Hindsight is a memory layer for AI applications with an API server and a control-plane web UI.

[GitHub Page](https://github.com/vectorize-io/hindsight)

## Notes

- This stack uses the official all-in-one container with embedded pg0 storage.
- Traefik exposes two hostnames:
  - `HINDSIGHT_API_PUBLIC_HOSTNAME` → API on container port `8888`
  - `HINDSIGHT_UI_PUBLIC_HOSTNAME` → Control Plane UI on container port `9999`
- No host ports are published directly.

## Setup

1. Edit `.env`:
   - Set `PROXY_NETWORK` to your external Traefik docker network.
   - Set both public hostnames.
   - Set `HINDSIGHT_API_LLM_API_KEY` to a valid provider key.
2. Start the stack:

```sh
docker compose up -d
```

3. Access via Traefik:
   - API: `https://${HINDSIGHT_API_PUBLIC_HOSTNAME}`
   - UI: `https://${HINDSIGHT_UI_PUBLIC_HOSTNAME}`
