#!/usr/bin/env bash

AUDIO_FILE="speech.wav"
MODEL="azure/gpt-4o-mini-transcribe"

curl -X POST "https://${PUBLIC_HOSTNAME}/v1/audio/transcriptions" \
  -H "x-bf-vk: ${VIR_KEY}" \
  -F "file=@${AUDIO_FILE}" \
  -F "model=${MODEL}" \
  -F "language=de" \
  -F "response_format=json"|jq
