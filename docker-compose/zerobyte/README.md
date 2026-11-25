# Zerobyte

Zerobyte is a backup automation tool that helps you save your data across multiple storage backends. Built on top of Restic, it provides an modern web interface to schedule, manage, and monitor encrypted backups of your remote storage.

[GitHub Page](https://github.com/nicotsx/zerobyte)

## Remote agents

Remote agent support is enabled by default. To disable it, set `ENABLE_REMOTE_AGENTS=false` in `.env` and recreate the server container with `docker compose up -d`.

Set `PUBLIC_HOSTNAME` to the server's reachable DNS name without `https://`. When Traefik terminates TLS, keep `TRUST_PROXY=true` and ensure Traefik forwards WebSocket upgrades and the `Authorization` header to `/api/v1/agents/connect`.

On the machine you want to back up, follow the [official remote agent guide](https://zerobyte.app/docs/guides/remote-agents). The agent connects outbound to Zerobyte and sends backups directly to the repository; it does not need an inbound port.