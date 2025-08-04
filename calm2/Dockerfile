ARG URI=https://huggingface.co/TheBloke/calm2-7B-chat-GGUF/resolve/main
ARG FILE=calm2-7b-chat.Q4_K_M.gguf

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

FROM ghcr.io/jobscale/llama.cpp AS llama.cpp

# bin だけ更新して llama.cpp を最新バージョンにしても元のモデルはキャッシュを利用する
FROM node:22.17.1-bookworm-slim
WORKDIR /home/node/llama.cpp
ARG FILE
COPY --from=content /home/node/${FILE} .

RUN apt-get update && apt-get install -y --no-install-recommends \
  curl libgomp1 \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=llama.cpp /home/node/llama.cpp/bin bin

USER node
WORKDIR /home/node/llama.cpp

ENV FILE=${FILE}
ENV LD_LIBRARY_PATH="bin"
EXPOSE 8080
CMD ["js/cmd.sh"]
