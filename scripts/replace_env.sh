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

# Replace the values using sed
sed -i '' "s|rpc_url = .*|rpc_url = \"$RPC_URL\"|" "$DOJO_DEV_FILE"
sed -i '' "s|account_address = .*|account_address = \"$ACCOUNT_ADDRESS\"|" "$DOJO_DEV_FILE"
sed -i '' "s|private_key = .*|private_key = \"$PRIVATE_KEY\"|" "$DOJO_DEV_FILE"

# echo "Values replaced successfully in $DOJO_DEV_FILE"
