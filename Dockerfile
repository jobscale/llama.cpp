FROM node:lts-trixie-slim AS build
SHELL ["bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
 ca-certificates git curl build-essential cmake \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

USER node
WORKDIR /home/node

RUN git clone --depth 1 https://github.com/ggerganov/llama.cpp.git \
&& mkdir llama.cpp/build

WORKDIR /home/node/llama.cpp/build

COPY version .
RUN cmake .. \
  -DLLAMA_CURL=OFF \
  -DLLAMA_CUBLAS=OFF \
  -DGGML_OPENBLAS=ON \
  -DGGML_CCACHE=OFF \
  -DCMAKE_C_FLAGS="-O3 -mavx2 -mfma" \
  -DCMAKE_CXX_FLAGS="-O3 -mavx2 -mfma" \
  -DCMAKE_BUILD_TYPE=Release \
&& cmake --build . --config Release

FROM node:lts-trixie-slim

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
  curl libgomp1 \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

USER node
WORKDIR /home/node/llama.cpp

COPY --from=build /home/node/llama.cpp/build/version .
COPY --from=build /home/node/llama.cpp/build/bin bin
COPY js/cmd.sh .

ENV LD_LIBRARY_PATH="bin"
EXPOSE 8080
CMD ["./cmd.sh"]
