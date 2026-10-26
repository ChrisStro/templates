#!/usr/bin/env bash
# List the models deployed on the LiteLLM gateway.
# Usage: PUBLIC_HOSTNAME=litellm.example.com VIR_KEY=sk-... ./curl_list_models.sh
curl -s "https://${PUBLIC_HOSTNAME}/v1/models" \
  -H "Authorization: Bearer ${VIR_KEY}" | jq '.data[].id'
