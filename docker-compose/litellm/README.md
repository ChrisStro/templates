# LiteLLM AI Gateway

LiteLLM is an OpenAI-compatible AI gateway: one API endpoint in front of many providers
(OpenAI, Anthropic, Gemini, Azure, Bedrock, Ollama, vLLM, …), with virtual keys, budgets,
spend tracking, failover and an Admin UI.

[GitHub Page](https://github.com/BerriAI/litellm)

This stack runs the gateway (`ghcr.io/berriai/litellm`) plus its PostgreSQL database. The
database is what enables virtual keys, spend logs and model management from the UI, so models
are added in the UI instead of in a config file (`STORE_MODEL_IN_DB=True`).

## Setup

1. Edit `.env`:
   - `PUBLIC_HOSTNAME` and `PROXY_NETWORK` as in every other stack here.
   - `POSTGRES_PASSWORD` — the database password.
   - `LITELLM_MASTER_KEY` — admin credential for the API and the Admin UI password.
   - `LITELLM_SALT_KEY` — encrypts the provider credentials stored in Postgres.

   Generate the two keys with `openssl rand -hex 32`, prefix them with `sk-` if you like. Compose
   refuses to start while any of the three is empty. Special characters in `POSTGRES_PASSWORD` have to
   be URL-encoded, because the password is part of `DATABASE_URL`.

   **`LITELLM_SALT_KEY` is a one-time decision.** It has no in-place rotation: once models or
   credentials exist in the database, changing the salt (or removing it and letting LiteLLM fall
   back to the master key) makes every stored credential unreadable. Back it up with the database,
   and treat `LITELLM_MASTER_KEY` as a root password — anyone holding it is proxy admin.

2. Start it:

   ```bash
   cd docker-compose/litellm
   docker compose up -d
   ```

   The first start applies the database schema, so give it a few minutes; the container healthcheck
   waits up to 120 seconds before it starts counting failures.

3. Open `https://$PUBLIC_HOSTNAME/ui` and log in as `admin` with the value of
   `LITELLM_MASTER_KEY`.

4. Add models under **Models + Endpoints → Add Model** (provider, model, provider API key). Click
   **Test Connect** before saving. To keep provider keys out of the UI, put them in `.env` and enter
   `os.environ/OPENAI_API_KEY` in the API-key field instead of the raw key.

5. Create a virtual key under **Virtual Keys** and hand that out to applications instead of provider
   keys — copy it immediately, it is shown only once. It carries its own budget, rate limits and
   model access, and every request it makes is logged with its cost.

## Testing

```bash
cd docker-compose/litellm/addl
PUBLIC_HOSTNAME=$PUBLIC_HOSTNAME VIR_KEY=sk-... ./curl_list_models.sh
PUBLIC_HOSTNAME=$PUBLIC_HOSTNAME VIR_KEY=sk-... MODEL=gpt-4o ./curl_chat-completion_api.sh
KEY_ALIAS=open-webui MAX_BUDGET=20 ./create_virtual_key.sh   # reads LITELLM_MASTER_KEY from ../.env
```

The requests must use a virtual key, not the master key, if you want budgets and spend tracking.

## Using it from the other stacks

The gateway is a drop-in OpenAI-compatible endpoint — no extra infrastructure in those stacks.
From a container on the same Docker network (`proxy_network`) use the service name:

- `open-webui`: `OPENAI_API_BASE_URL=http://litellm:4000/v1`, `OPENAI_API_KEY=sk-<virtual key>`
- `paperless-ngx/paperless-gpt`: `OPENAI_BASE_URL=http://litellm:4000/v1`, `OPENAI_API_KEY=sk-<virtual key>`,
  and `LLM_MODEL` / `VISION_LLM_MODEL` set to a model name deployed on the gateway.

From outside, use `https://$PUBLIC_HOSTNAME/v1`. Give a consumer a **virtual key**, never
`LITELLM_MASTER_KEY`, or its spend stays untracked and unlimited. The model names a consumer sends must
match a `model_name` deployed on the gateway.

## Notes

- No port is published; the only entry point is Traefik on `$PROXY_NETWORK`. Postgres stays on the
  internal `backend` network.
- Pin the image with `LITELLM_IMAGE_TAG` in `.env`. `latest` is the rolling stable pointer upstream
  allows; a content tag keeps upgrades reviewable. The `main-stable` tag LiteLLM used to document is
  deprecated and being retired.
- Optional, deliberately not deployed here: Redis (response caching, rate limits, more than one
  gateway instance), Prometheus scraping, and a file-based `model_list` — see the commented block in
  `compose.yaml` for the file variant.
