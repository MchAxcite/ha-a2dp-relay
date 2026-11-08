ARG BUILD_FROM=ghcr.io/sl1288/a2dp-relay-bridge:latest
FROM ${BUILD_FROM}

RUN apt-get update \
    && apt-get install -y --no-install-recommends jq \
    && rm -rf /var/lib/apt/lists/*

COPY run.sh /run.sh
RUN chmod a+x /run.sh

ENTRYPOINT ["/run.sh"]
