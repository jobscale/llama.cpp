ARG URI=https://huggingface.co/TheBloke/calm2-7B-chat-GGUF/resolve/main
ARG FILE=calm2-7b-chat.Q4_K_M.gguf

FROM ghcr.io/jobscale/llama.cpp AS llama.cpp

# モデルはキャッシュを利用する
FROM node:22.17.1-bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates curl libgomp1 \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /home/node/llama.cpp
USER node
COPY --chmod=go+rX js js
ARG URI
ARG FILE
RUN curl -sSLo "${FILE}" -H "Authorization: Bearer $(node js)" "${URI}/${FILE}?download=true"
COPY --from=llama.cpp /home/node/llama.cpp/bin bin

ENV FILE=${FILE}
ENV LD_LIBRARY_PATH="bin"
EXPOSE 8080
CMD ["js/cmd.sh"]
