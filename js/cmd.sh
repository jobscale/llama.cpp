#!/usr/bin/env bash
set -eu

args=(--model "$MODEL_FILE" --host 0.0.0.0)

if [[ -n "${DRAFT_FILE:-}" ]]; then
  args+=(
    --model-draft "$DRAFT_FILE"
    --spec-type draft-mtp
    --spec-draft-n-max 4
    --flash-attn off
  )
fi

bin/llama-server "${args[@]}"
