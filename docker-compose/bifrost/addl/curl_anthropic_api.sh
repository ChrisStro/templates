curl -X POST https://$PUBLIC_HOSTNAME/anthropic/v1/messages \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $VIR_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "dmr_openai/docker.io/ai/gemma4:26b-256k",
    "max_tokens": 256000,
    "messages": [{"role": "user", "content": "Hello, which model are you? Give me informations about your max context and token size!"}]
  }'|jq