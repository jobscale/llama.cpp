ARG URI=https://huggingface.co/lmstudio-community/Phi-4-mini-reasoning-GGUF/resolve/main
ARG FILE=Phi-4-mini-reasoning-Q4_K_M.gguf

FROM ghcr.io/jobscale/llama.cpp AS content
ARG URI
ARG FILE
RUN curl -sL -o "${FILE}" -H "Authorization: Bearer $(node js)" "${URI}/${FILE}?download=true"

FROM ghcr.io/jobscale/llama.cpp

ARG FILE
COPY --from=content /home/node/llama.cpp/${FILE} .

ENV FILE=${FILE}
