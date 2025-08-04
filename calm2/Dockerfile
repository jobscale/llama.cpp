ARG URI=https://huggingface.co/TheBloke/calm2-7B-chat-GGUF/resolve/main
ARG FILE=calm2-7b-chat.Q4_K_M.gguf

FROM node:lts-bookworm-slim AS content
WORKDIR /home/node
USER node
ARG URI
ARG FILE
RUN curl -L -o "$FILE" -H "Authorization: Bearer $(node js)" "${URI}/${FILE}?download=true"

FROM ghcr.io/jobscale/llama.cpp

ARG FILE
COPY --from=content /home/node/${FILE} .

ENV FILE=${FILE}
