ARG URI=https://huggingface.co/QuantFactory/Llama-3-ELYZA-JP-8B-GGUF/resolve/main
ARG FILE=Llama-3-ELYZA-JP-8B.Q4_K_M.gguf

FROM ghcr.io/jobscale/llama.cpp AS content
ARG URI
ARG FILE
RUN curl -sL -o "${FILE}" -H "Authorization: Bearer $(node js)" "${URI}/${FILE}?download=true"

FROM ghcr.io/jobscale/llama.cpp

ARG FILE
COPY --from=content /home/node/llama.cpp/${FILE} .

ENV FILE=${FILE}
