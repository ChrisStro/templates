#!/usr/bin/env bash

base64 -w0 test.png |
  jq -Rs '{
  model: "ollama/gemma4:26b",
  stream: false,
  messages: [{
    role: "user",
    content: [
      {
        type: "text",
        text: "Transcribe all text visible in this document. Return only the transcription."
      },
      {
        type: "image_url",
        image_url: {
          url: ("data:image/png;base64," + .)
        }
      }
    ]
  }]
}' |
  curl -v \
    "https://${PUBLIC_HOSTNAME}/v1/chat/completions" \
    -H "Content-Type: application/json" \
    -H "x-bf-vk: ${VIR_KEY}" \
    --data-binary @- |
  jq
