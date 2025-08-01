FROM node:lts-bookworm-slim
SHELL ["bash", "-c"]

RUN apt-get update && apt-get install -y build-essential curl git cmake \
&& apt-get clean

USER node
WORKDIR /home/node

RUN git clone --depth 1 https://github.com/ggerganov/llama.cpp.git \
&& mkdir llama.cpp/build

WORKDIR /home/node/llama.cpp/build

RUN cmake .. \
  -DLLAMA_CURL=OFF \
  -DLLAMA_CUBLAS=OFF \
  -DGGML_OPENBLAS=ON \
  -DGGML_CCACHE=OFF \
  -DCMAKE_C_FLAGS="-O3 -mavx2 -mfma" \
  -DCMAKE_CXX_FLAGS="-O3 -mavx2 -mfma" \
  -DCMAKE_BUILD_TYPE=Release \
&& cmake --build . --config Release

COPY --chmod=go+rX js js

ENV URI=https://huggingface.co/TheBloke/calm2-7B-chat-GGUF/resolve/main
ENV FILE=calm2-7b-chat.Q4_K_M.gguf
RUN curl -L -o "$FILE" -H "Authorization: Bearer $(node js)" "$URI/$FILE?download=true"

EXPOSE 8080

CMD bash -euc "bin/llama-server --model \$FILE --host 0.0.0.0"
