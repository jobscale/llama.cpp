FROM ghcr.io/jobscale/llama.cpp

ENV URI=https://huggingface.co/unsloth/gemma-3-4b-it-GGUF/resolve/main
ENV FILE=gemma-3-4b-it-Q4_K_M.gguf
RUN curl -L -o "$FILE" -H "Authorization: Bearer $(node js)" "$URI/$FILE?download=true"
