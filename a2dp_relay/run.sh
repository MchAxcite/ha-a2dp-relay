#!/bin/sh
set -e

CONFIG="/data/options.json"
BRIDGE_CONFIG="/data/bridge.yaml"

MA_HOST=$(jq -r '.music_assistant_host' "$CONFIG")
MA_PORT=$(jq -r '.music_assistant_port' "$CONFIG")
ESP32_HOST=$(jq -r '.esp32_host' "$CONFIG")
ESP32_PORT=$(jq -r '.esp32_port' "$CONFIG")
RELAY_NAME=$(jq -r '.relay_name' "$CONFIG")

cat > "$BRIDGE_CONFIG" <<EOF
music_assistant:
  sendspin_url: "ws://${MA_HOST}:${MA_PORT}/sendspin"

web:
  listen: ":8099"

state_file: "/data/state.json"

nodes:
  - address: "${ESP32_HOST}:${ESP32_PORT}"
    name: "${RELAY_NAME}"
EOF

echo "Starting A2DP Relay Bridge..."
echo "Music Assistant: ${MA_HOST}:${MA_PORT}"
echo "ESP32 relay: ${ESP32_HOST}:${ESP32_PORT}"

exec /usr/local/bin/a2dp-bridge -config "$BRIDGE_CONFIG"
