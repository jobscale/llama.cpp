FROM node:lts-bookworm-slim
SHELL ["bash", "-c"]

RUN apt-get update && apt-get install -y build-essential curl git cmake \
&& apt-get clean

USER node
WORKDIR /home/node

RUN git clone https://github.com/ggerganov/llama.cpp.git \
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
RUN curl -L -o gemma-3-4b-it-Q4_K_M.gguf -H "Authorization: Bearer $(node js)" \
  'https://huggingface.co/unsloth/gemma-3-4b-it-GGUF/resolve/main/gemma-3-4b-it-Q4_K_M.gguf?download=true'

EXPOSE 8080

CMD ["bin/llama-server", "--model", "gemma-3-4b-it-Q4_K_M.gguf", "--host", "0.0.0.0"]
