FROM ghcr.io/jobscale/llama.cpp

ENV URI=https://huggingface.co/TheBloke/calm2-7B-chat-GGUF/resolve/main
ENV FILE=calm2-7b-chat.Q4_K_M.gguf
RUN curl -L -o "$FILE" -H "Authorization: Bearer $(node js)" "$URI/$FILE?download=true"
