FROM node:lts-bookworm-slim AS build
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

FROM node:lts-bookworm-slim

RUN apt-get update && apt-get install -y curl libgomp1 \
&& apt-get clean

USER node
WORKDIR /home/node/llama.cpp

COPY --from=build /home/node/llama.cpp/build/bin bin
COPY --chmod=go+rX js js

ENV LD_LIBRARY_PATH="bin"
EXPOSE 8080
CMD ["js/cmd.sh"]

# llama.cpp base container
# - ghcr.io/jobscale/llama.cpp
