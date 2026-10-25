---
id: paperless-ngx-deployment
type: module-design
status: draft
title: Paperless-ngx deployment and optional AI integration
---

## Responsibility

Dieses Modul stellt eine lauffähige Paperless-ngx-Compose-Vorlage bereit und
kapselt optionale Erweiterungen als explizit aktivierbare Zusatzdateien.

## Boundary

- `compose.yaml` bleibt der stabile Basis-Stack für Paperless-ngx
  (Datenbank, Redis, Webserver, Proxy-Labels).
- Optionale Integrationen dürfen den Basisbetrieb nicht verändern, solange ihre
  Override-Datei nicht geladen wird.
- Integrationen nutzen das bestehende `backend`-Netz für interne API-Aufrufe und
  veröffentlichen nur die für ihren Zweck nötigen Endpunkte.

## Optional Paperless-GPT integration contract

Die Erweiterung unter `paperless-gpt/` gilt nur bei expliziter Aktivierung per
zweiter Compose-Datei und zweiter Env-Datei.

- **Activation:** Start immer mit `-f compose.yaml -f paperless-gpt/compose.override.yaml`
  und `--env-file .env --env-file paperless-gpt/.env`.
- **Core dependency:** `paperless-gpt` spricht Paperless-ngx intern über
  `http://webserver:8000` an und startet erst nach gesundem `webserver`.
- **Exposure model:** Zugriff nur lokal über `127.0.0.1:${PAPERLESS_GPT_PORT}`;
  kein Join ins `proxy_network`, keine Traefik-Router.
- **Secrets:** `PAPERLESS_API_TOKEN` und `OPENAI_API_KEY` sind Pflichtwerte und
  müssen außerhalb des Repositories gesetzt werden.
- **Persistence:** Prompts, UI-Konfiguration und Verlauf liegen in eigenen
  Named Volumes (`paperless_gpt_prompts`, `paperless_gpt_config`,
  `paperless_gpt_db`).
- **Processing defaults:** Metadaten- und OCR-Verarbeitung erfolgt tag-gesteuert;
  PDF-Upload und Ersetzen von Originaldokumenten sind standardmäßig deaktiviert.
