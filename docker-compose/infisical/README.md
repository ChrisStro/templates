# Infisical

Infisical is an open-source end-to-end encrypted secrets management platform for teams to sync and manage .env files, secrets, and configs across infrastructure and environments.

[GitHub Page](https://github.com/Infisical/infisical)
[Official Docker Compose Docs](https://infisical.com/docs/self-hosting/deployment-options/docker-compose)

## Netzwerk-Setup

Dieses Template nutzt zwei Netzwerke:

- `backend_network` (intern): Kommunikation zwischen `backend`, `db`, `redis`
- `proxy_network` (extern): nur der `backend` Service hängt daran, damit Traefik den Service erreichen kann

Damit sind Datenbank und Redis **nicht direkt extern erreichbar**.

## Setup

### 1. `.env` befüllen

Pflichtfelder:

- `PUBLIC_HOSTNAME`
- `PROXY_NETWORK`
- `POSTGRES_PASSWORD`
- `ENCRYPTION_KEY` (z. B. `openssl rand -hex 32`)
- `AUTH_SECRET` (z. B. `openssl rand -hex 32`)

Optionale Image-Tags (mit sinnvollen Defaults):

- `INFISICAL_IMAGE_TAG` (default: `latest`)
- `POSTGRES_IMAGE_TAG` (default: `14-alpine`)
- `REDIS_IMAGE_TAG` (default: `7-alpine`)

### 2. Start

```bash
docker compose up -d
```

### 3. Zugriff

Dann über `https://<PUBLIC_HOSTNAME>` aufrufen.

## Hinweise

- Compose orientiert sich an der offiziellen Infisical Docker-Compose-Variante (Backend + Postgres + Redis).
- Für Traefik wurde die Portfreigabe durch Labels ersetzt.
- Für produktive Nutzung besser auf feste Image-Tags pinnen (statt `latest`).