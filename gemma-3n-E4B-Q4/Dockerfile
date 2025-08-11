ARG URI=https://huggingface.co/unsloth/gemma-3n-E4B-it-GGUF
ARG FILE=gemma-3n-E4B-it-Q4_K_M.gguf

FROM ghcr.io/jobscale/llama.cpp AS llama.cpp
COPY version llama.cpp-version

# モデルはキャッシュを利用する
FROM node:22.17.1-bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates curl libgomp1 \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /home/node/llama.cpp
RUN chown -R node:staff .
USER node
COPY --chmod=go+rX js js
ARG URI
ARG FILE
RUN curl -sSLo "${FILE}" -H "Authorization: Bearer $(node js)" \
  "${URI}/resolve/main/${FILE}?download=true"

COPY --from=llama.cpp /home/node/llama.cpp/bin bin

ENV FILE=${FILE}
ENV LD_LIBRARY_PATH="bin"
EXPOSE 8080
CMD ["js/cmd.sh"]
