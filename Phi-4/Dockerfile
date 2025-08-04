ARG URI=https://huggingface.co/lmstudio-community/Phi-4-mini-reasoning-GGUF/resolve/main
ARG FILE=Phi-4-mini-reasoning-Q4_K_M.gguf

FROM node:lts-bookworm-slim AS content
RUN apt-get update && apt-get install -y curl \
&& apt-get clean
WORKDIR /home/node
USER node
ARG URI
ARG FILE
RUN curl -L -o "$FILE" -H "Authorization: Bearer $(node js)" "${URI}/${FILE}?download=true"

FROM ghcr.io/jobscale/llama.cpp

ARG FILE
COPY --from=content /home/node/${FILE} .

ENV FILE=${FILE}
