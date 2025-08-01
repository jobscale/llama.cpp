FROM ghcr.io/jobscale/llama.cpp

ENV URI=https://huggingface.co/lmstudio-community/Phi-4-mini-reasoning-GGUF/resolve/main
ENV FILE=Phi-4-mini-reasoning-Q4_K_M.gguf
RUN curl -L -o "$FILE" -H "Authorization: Bearer $(node js)" "$URI/$FILE?download=true"
