ARG URI=https://huggingface.co/QuantFactory/Llama-3-ELYZA-JP-8B-GGUF/resolve/main
ARG FILE=Llama-3-ELYZA-JP-8B.Q4_K_M.gguf

# ベースイメージを固定してキャッシュしたモデルを使う
FROM node:22.17.1-bookworm-slim AS content
RUN apt-get update && apt-get install -y curl \
&& apt-get clean && rm -rf /var/lib/apt/lists/*
USER node
WORKDIR /home/node
COPY --chmod=go+rX js js
ARG URI
ARG FILE
RUN curl -sSLo "${FILE}" -H "Authorization: Bearer $(node js)" "${URI}/${FILE}?download=true"

FROM ghcr.io/jobscale/llama.cpp

ARG FILE
COPY --from=content /home/node/${FILE} .

ENV FILE=${FILE}
