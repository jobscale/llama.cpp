#!/usr/bin/env bash
set -eu

bin/llama-server --model $FILE --host 0.0.0.0
