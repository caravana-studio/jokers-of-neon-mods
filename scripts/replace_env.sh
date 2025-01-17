#!/bin/bash

set -e

MOD_NAME=$1
ACCOUNT_ADDRESS=$2
PRIVATE_KEY=$3
RPC_URL=$4

# Replace values in dojo_dev.toml
DOJO_DEV_FILE="dojo_dev.toml"

if [ ! -f "$DOJO_DEV_FILE" ]; then
    echo "Error: dojo_dev.toml not found at $DOJO_DEV_FILE"
    exit 1
fi

# Replace the values using sed
sed -i '' "s|default = .*|default = \"$MOD_NAME\"|" "$DOJO_DEV_FILE"
sed -i '' "s|rpc_url = .*|rpc_url = \"$RPC_URL\"|" "$DOJO_DEV_FILE"
sed -i '' "s|account_address = .*|account_address = \"$ACCOUNT_ADDRESS\"|" "$DOJO_DEV_FILE"
sed -i '' "s|private_key = .*|private_key = \"$PRIVATE_KEY\"|" "$DOJO_DEV_FILE"

echo "Values replaced successfully in $DOJO_DEV_FILE"
