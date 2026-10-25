# Paperless-GPT override

[Paperless-GPT](https://github.com/icereed/paperless-gpt) adds AI-generated
metadata and vision-LLM OCR to the existing Paperless-ngx stack. This override
uses OpenAI or an OpenAI-compatible API; it does not deploy a model server.

## Configuration

Run all Compose commands below from `docker-compose/paperless-ngx`.

1. Configure the base `.env` as usual, including the Paperless hostname, database
   credentials and existing proxy network. Paperless-ngx itself continues to use
   that network; Paperless-GPT does not.
2. Create or retrieve a Paperless-ngx API token in the user profile. Its account
   needs permission to read and update the target documents and their metadata.
3. Edit `paperless-gpt/.env` locally:
   - `PAPERLESS_API_TOKEN`: the Paperless-ngx token.
   - `OPENAI_API_KEY`: your provider's API key. For a trusted, unauthenticated
     local gateway that requires no key, use a non-empty dummy value.
   - `OPENAI_BASE_URL`: the provider's API base URL, including `/v1` when required.
     The default is `https://api.openai.com/v1`.
   - `LLM_MODEL`: the model for metadata; the example uses `gpt-4o`.
   - `VISION_LLM_MODEL`: a vision-capable model for OCR; the example uses `gpt-4o`.
     The endpoint must support image input, not just text chat completions.
   - `LLM_LANGUAGE`: document/output language hint, default `German`.
   - `PAPERLESS_GPT_PORT`: local host port, default `8080`.
   - `OCR_LIMIT_PAGES`: initially `5`; set to `0` for all pages. With the default,
     longer documents are only OCRed up to the page limit. Adjust it before
     processing documents whose entire text you need.

The checked-in `.env` is a template with empty credentials. Never commit real
keys or tokens. Compose rejects missing or empty credentials when the override
is selected. Keep local credential files private.

**Privacy and costs:** document text and page images are sent to the configured
provider. Choose a trusted endpoint and review its data-handling policy and API
pricing before applying processing tags. Back up Paperless-ngx before bulk edits.

## Start

Explicitly load both environment files and both Compose files:

```sh
docker compose --env-file .env --env-file paperless-gpt/.env \
  -f compose.yaml -f paperless-gpt/compose.override.yaml config --quiet

docker compose --env-file .env --env-file paperless-gpt/.env \
  -f compose.yaml -f paperless-gpt/compose.override.yaml up -d
```

`--env-file` supplies Compose interpolation values; the second file supplements
(and on duplicate keys overrides) the base `.env`. Placing a `.env` next to the
override does not make Compose load it automatically. Use the same file options
for subsequent commands on the extended stack. Use Docker Compose v2 with
support for multiple `--env-file` arguments.

Paperless-GPT connects to `http://webserver:8000` on the existing backend network
and waits for the Paperless-ngx webserver healthcheck. Its API connection does not
go through the public reverse proxy. Prompts, UI settings and processing history
persist in separate named volumes.

## Local access

Open `http://127.0.0.1:8080` on the Docker host (or your chosen local port).
For a remote host, forward that port through SSH:

```sh
ssh -N -L 8080:127.0.0.1:8080 user@docker-host
```

Then open the same local URL. If you changed `PAPERLESS_GPT_PORT`, change the
remote forwarding port accordingly.

**Paperless-GPT has no built-in authentication.** The override binds the published
port to IPv4 loopback, disables Traefik discovery and does not join the proxy
network. Local users and containers on the backend network can still reach the
service. Do not expose it on an untrusted network without additional authentication.

## Processing documents

Apply the appropriate tag in Paperless-ngx:

- `paperless-gpt`: queue documents for manual metadata suggestions/review in
  the Paperless-GPT UI.
- `paperless-gpt-auto`: automatically generate metadata such as titles, tags
  and correspondents for tagged documents.
- `paperless-gpt-ocr-auto`: automatically perform vision-LLM OCR for tagged
  documents.

Untagged documents are not automatically processed just because the service is
running. Start with a test document and review the results before tagging a batch.
The override uses image-based OCR and disables PDF uploads and replacement by
default; it does not set up searchable-PDF generation. OCR can still update the
extracted text in Paperless-ngx. Some OCR defaults, including the page limit and
PDF handling, can be overridden by saved UI settings or per-run settings; review
the active settings before processing.

## Troubleshooting and deactivation

Check service logs without printing the resolved configuration and its secrets:

```sh
docker compose --env-file .env --env-file paperless-gpt/.env \
  -f compose.yaml -f paperless-gpt/compose.override.yaml logs --tail=100 paperless-gpt
```

For credential errors, check the two required values and that both environment
files were loaded. For API/model errors, check the provider URL, model names,
vision support and the Paperless account's permissions. An unhealthy `webserver`
prevents Paperless-GPT from starting; check the base stack first.

To disable the extension without stopping Paperless-ngx or deleting its data:

```sh
docker compose --env-file .env --env-file paperless-gpt/.env \
  -f compose.yaml -f paperless-gpt/compose.override.yaml stop paperless-gpt

docker compose --env-file .env --env-file paperless-gpt/.env \
  -f compose.yaml -f paperless-gpt/compose.override.yaml rm -f paperless-gpt
```

Afterwards, omit the override and its environment file from future base-stack
commands. The Paperless-GPT named volumes remain for later reactivation. Do not
use `down -v` unless you intend to delete the stack's named volumes, including
Paperless-ngx's database and document storage.
