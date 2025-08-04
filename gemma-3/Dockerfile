ARG URI=https://huggingface.co/unsloth/gemma-3-4b-it-GGUF/resolve/main
ARG FILE=gemma-3-4b-it-Q4_K_M.gguf

FROM ghcr.io/jobscale/llama.cpp AS content
ARG URI
ARG FILE
RUN curl -sL -o "${FILE}" -H "Authorization: Bearer $(node js)" "${URI}/${FILE}?download=true"

FROM ghcr.io/jobscale/llama.cpp

ARG FILE
COPY --from=content /home/node/llama.cpp/${FILE} .

ENV FILE=${FILE}
