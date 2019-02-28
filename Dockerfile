FROM debian:stretch-slim

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends dnsutils fping && \
    rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /entrypoint.sh

WORKDIR /data

CMD /entrypoint.sh
