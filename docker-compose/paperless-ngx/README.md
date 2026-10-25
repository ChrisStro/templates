# Paperless-ngx

Paperless-ngx is a document management system that transforms your physical documents into a searchable online archive so you can keep, well, less paper.

[GitHub Page](https://github.com/paperless-ngx/paperless-ngx)

## Optional Paperless-GPT extension

The [Paperless-GPT override](paperless-gpt/README.md) adds AI-assisted metadata and
LLM-based OCR via OpenAI or an OpenAI-compatible API. It is opt-in: the base
`compose.yaml` does not start Paperless-GPT.

The extension's web UI is available only at `http://127.0.0.1:8080` by default,
without a Traefik route. See the extension guide for credentials, activation,
SSH access, processing tags and deactivation.