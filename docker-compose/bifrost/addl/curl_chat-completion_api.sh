#!/bin/env bash
curl -X POST https://$PUBLIC_HOSTNAME/v1/chat/completions \
	-H "x-bf-vk: $VIR_KEY" \
	-H "Content-Type: application/json" \
	-d '{
		"model": "azure-foundry/gpt-5.4-nano",
		"messages": [{"role": "user", "content": "Hello"}]
	}'|jq