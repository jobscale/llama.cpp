FROM ghcr.io/jobscale/llama.cpp

ENV URI=https://huggingface.co/QuantFactory/Llama-3-ELYZA-JP-8B-GGUF/resolve/main
ENV FILE=Llama-3-ELYZA-JP-8B.Q4_K_M.gguf
RUN curl -L -o "$FILE" -H "Authorization: Bearer $(node js)" "$URI/$FILE?download=true"

EXPOSE 8080

CMD bash -euc "bin/llama-server --model \$FILE --host 0.0.0.0"
