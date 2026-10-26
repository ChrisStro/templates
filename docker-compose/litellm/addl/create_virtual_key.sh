#!/usr/bin/env bash
# Create a virtual key for an application on the LiteLLM gateway.
# Reads LITELLM_MASTER_KEY from the stack's .env, one level above this folder.
# Usage: PUBLIC_HOSTNAME=litellm.example.com KEY_ALIAS=open-webui ./create_virtual_key.sh
set -euo pipefail

MASTER_KEY="$(sed -n 's/^LITELLM_MASTER_KEY=//p' "$(dirname "$0")/../.env")"

curl -s -X POST "https://${PUBLIC_HOSTNAME}/key/generate" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${MASTER_KEY}" \
  -d "{
    \"key_alias\": \"${KEY_ALIAS:-template-key}\",
    \"duration\": \"30d\",
    \"models\": [\"*\"],
    \"max_budget\": ${MAX_BUDGET:-null},
    \"budget_duration\": \"30d\"
  }" | jq
