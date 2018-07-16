FROM ubuntu:bionic

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends fping && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /data

CMD while true ; do printf "%s %s\n" "$(date "+%F %T%z")" "$(fping -t 1000 -q 4.2.2.1 && echo alive || echo FAILURE)" | tee -a "wan_connection-$(date +%F).log" ; sleep 5 ; done ;
