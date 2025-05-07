FROM alpine:3

RUN apk add --no-cache git make cmake libstdc++ gcc g++ libuv-dev openssl-dev hwloc-dev

RUN git clone https://github.com/xmrig/xmrig /xmrig

RUN mkdir /xmrig/build && cd /xmrig/build && \
    cmake .. && \
    make -j$(nproc) && \
    chmod +x /xmrig/build/xmrig && \
    rm -r /xmrig/src

COPY config.json /xmrig/build/config.json

WORKDIR /xmrig/build

ENTRYPOINT ["./xmrig", "--url", "${MINING_POOL}", "--user", "${WALLET_ADDRESS}", "--pass", "x", "--coin", "monero", "--worker-name", "${WORKER_NAME}", "--keepalive"]
