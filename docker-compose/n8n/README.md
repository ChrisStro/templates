# n8n Docker Compose Template

Dieses Verzeichnis ist ein Template für einen n8n Compose-Stack.

## Deployment-Methoden

Die Deployment-Methode wird über `COMPOSE_FILE` in `.env` gesteuert:

- **Default (ohne Assistant/Sandbox):**
  - `COMPOSE_FILE=compose.yaml`
- **Optional (mit Assistant/Sandbox):**
  - `COMPOSE_FILE=compose.yaml:compose.assistant.yaml`

> Docker Compose liest `COMPOSE_FILE` automatisch aus `.env`.

## Starten

```bash
docker compose up -d
```

## Dateien

- `compose.yaml` → Basis-Stack (Postgres + n8n)
- `compose.assistant.yaml` → zusätzlicher Assistant/Sandbox-Stack
- `searxng-settings.yml` → SearXNG JSON-API Aktivierung für Assistant Web Search

[GitHub Page](https://github.com/n8n-io/n8n)