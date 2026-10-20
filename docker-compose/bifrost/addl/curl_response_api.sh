#!/bin/env bash
#!/bin/env bash
curl -X POST https://$PUBLIC_HOSTNAME/v1/responses \
	-H "x-bf-vk: $VIR_KEY" \
	-H "Content-Type: application/json" \
	-d '{
		"model": "azure-foundry/gpt-5.3-codex",
		"input": "Hello"
	}'|jq
