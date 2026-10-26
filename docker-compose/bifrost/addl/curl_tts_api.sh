#!/usr/bin/env bash

VOICE="marin"

curl -X POST "https://${PUBLIC_HOSTNAME}/v1/audio/speech" \
  -H "x-bf-vk: ${VIR_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"azure/gpt-4o-mini-tts\",
    \"voice\": \"${VOICE}\",
    \"response_format\": \"wav\",
    \"input\": \"Hi, das ist die Stimme von ${VOICE}\"
  }" \
  --output speech.wav

aplay speech.wav
#rm speech.wav
