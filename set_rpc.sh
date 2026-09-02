#!/bin/bash
set -euo pipefail

PROFILE="${1:?Usage: $0 <profile>}"
ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_TOML="$ROOT_DIR/dojo_${PROFILE}.toml"
TARGET_TOML="$ROOT_DIR/mods/jokers_of_neon_classic/dojo_dev.toml"

if [ ! -f "$SOURCE_TOML" ]; then
    echo "Error: $SOURCE_TOML not found"
    exit 1
fi

# Extract rpc_url value from source toml
RPC_URL=$(grep '^rpc_url' "$SOURCE_TOML" | sed 's/.*= *"\(.*\)"/\1/')

if [ -z "$RPC_URL" ]; then
    echo "Error: rpc_url not found in $SOURCE_TOML"
    exit 1
fi

# Replace rpc_url in target toml (GNU sed on Linux, BSD sed on macOS).
if sed --version >/dev/null 2>&1; then
    sed -i "s|^rpc_url = .*|rpc_url = \"$RPC_URL\"|" "$TARGET_TOML"
else
    sed -i '' "s|^rpc_url = .*|rpc_url = \"$RPC_URL\"|" "$TARGET_TOML"
fi

echo "Updated rpc_url in $TARGET_TOML to: $RPC_URL"
