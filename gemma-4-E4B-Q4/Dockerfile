ARG MODEL_URI=https://huggingface.co/unsloth/gemma-4-E4B-it-qat-GGUF/resolve/main
ARG MODEL_FILE=gemma-4-E4B-it-qat-UD-Q4_K_XL.gguf
ARG DRAFT_URI=https://huggingface.co/unsloth/gemma-4-E4B-it-qat-GGUF/resolve/main/MTP
ARG DRAFT_FILE=mtp-gemma-4-E4B-it-Q4_0.gguf

FROM ghcr.io/jobscale/llama.cpp AS llama.cpp
COPY version llama.cpp-version

# モデルはキャッシュを利用する
FROM node:24.12.0-trixie-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates curl libgomp1 \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /home/node/llama.cpp
RUN chown -R node:staff .
USER node
COPY --chmod=go+rX js js
ARG MODEL_URI
ARG MODEL_FILE
ARG DRAFT_URI
ARG DRAFT_FILE
RUN curl -sSLo "${MODEL_FILE}" -H "Authorization: Bearer $(node js)" \
  "${MODEL_URI}/${MODEL_FILE}?download=true" \
 && curl -sSLo "${DRAFT_FILE}" -H "Authorization: Bearer $(node js)" \
  "${DRAFT_URI}/${DRAFT_FILE}?download=true"

COPY --from=llama.cpp /home/node/llama.cpp/bin bin

ENV MODEL_FILE=${MODEL_FILE}
ENV DRAFT_FILE=${DRAFT_FILE}
ENV LD_LIBRARY_PATH="bin"
EXPOSE 8080
CMD ["js/cmd.sh"]
