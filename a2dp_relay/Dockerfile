FROM golang:1.27-trixie AS build

RUN sed -i 's/^Components: main$/Components: main non-free/' /etc/apt/sources.list.d/debian.sources \
 && apt-get update \
 && apt-get install -y --no-install-recommends libfdk-aac-dev libldacbt-enc-dev libfreeaptx-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY src/go.mod src/go.sum ./
RUN go mod download

COPY src/ ./

ARG VERSION=ha-48k-test1
RUN CGO_ENABLED=1 go build -trimpath \
    -ldflags="-s -w -X github.com/sl1288/a2dp-relay-bridge/internal/bridge.Version=${VERSION}" \
    -o /out/a2dp-bridge ./cmd/a2dp-bridge


FROM debian:trixie-slim

RUN sed -i 's/^Components: main$/Components: main non-free/' /etc/apt/sources.list.d/debian.sources \
 && apt-get update \
 && apt-get install -y --no-install-recommends libfdk-aac2 libldacbt-enc2 libfreeaptx0 ca-certificates tzdata jq \
 && rm -rf /var/lib/apt/lists/*

COPY --from=build /out/a2dp-bridge /usr/local/bin/a2dp-bridge
COPY run.sh /run.sh
RUN chmod a+x /run.sh

VOLUME /data
WORKDIR /data

ENTRYPOINT ["/run.sh"]
