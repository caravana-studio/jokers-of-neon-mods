#!/bin/bash

set -e

ACCOUNT_ADDRESS=$1
PRIVATE_KEY=$2
RPC_URL=$3

# Replace values in dojo_dev.toml
DOJO_DEV_FILE="dojo_dev.toml"

if [ ! -f "$DOJO_DEV_FILE" ]; then
    echo "Error: dojo_dev.toml not found at $DOJO_DEV_FILE"
    exit 1
fi

# GNU sed (Linux) and BSD sed (macOS) use different -i syntax.
sed_in_place() {
    if sed --version >/dev/null 2>&1; then
        sed -i "$1" "$DOJO_DEV_FILE"
    else
        sed -i '' "$1" "$DOJO_DEV_FILE"
    fi
}

sed_in_place "s|rpc_url = .*|rpc_url = \"$RPC_URL\"|"
sed_in_place "s|account_address = .*|account_address = \"$ACCOUNT_ADDRESS\"|"
sed_in_place "s|private_key = .*|private_key = \"$PRIVATE_KEY\"|"

# echo "Values replaced successfully in $DOJO_DEV_FILE"
