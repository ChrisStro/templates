#!/usr/bin/env bash
# Chat completion through the LiteLLM gateway.
# Usage: PUBLIC_HOSTNAME=litellm.example.com VIR_KEY=sk-... MODEL=openai/gpt-4o ./curl_chat-completion_api.sh
curl -s -X POST "https://${PUBLIC_HOSTNAME}/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${VIR_KEY}" \
  -d "{
    \"model\": \"${MODEL:-gpt-4o}\",
    \"messages\": [{\"role\": \"user\", \"content\": \"Hello, which model are you?\"}]
  }" | jq
