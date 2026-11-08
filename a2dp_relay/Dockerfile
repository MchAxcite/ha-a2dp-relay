ARG BUILD_FROM=ghcr.io/sl1288/a2dp-relay-bridge:latest
FROM ${BUILD_FROM}

COPY run.sh /run.sh
RUN chmod a+x /run.sh

ENTRYPOINT ["/run.sh"]
