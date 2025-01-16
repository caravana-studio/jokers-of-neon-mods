#!/bin/bash

set -e

MOD_NAME=$1

ENV_FILE="../../.env"

# Check if .env exists
if [ ! -f "$ENV_FILE" ]; then
    echo "Error: .env file not found"
    exit 1
fi

# Function to get and validate env variable
get_env_var() {
    local var_name=$1
    local value=$(grep "^$var_name=" "$ENV_FILE" | cut -d '=' -f2)
    
    if [ -z "$value" ]; then
        echo "Error: $var_name not found in .env file"
        exit 1
    fi
    echo "$value"
}

# Store variables
ACCOUNT_ADDRESS=$(get_env_var "ACCOUNT_ADDRESS")
PRIVATE_KEY=$(get_env_var "PRIVATE_KEY")
RPC_URL=$(get_env_var "RPC_URL")

# Print the stored variables
echo "Variables loaded:"
echo "ACCOUNT_ADDRESS=$ACCOUNT_ADDRESS"
echo "PRIVATE_KEY=$PRIVATE_KEY"
echo "RPC_URL=$RPC_URL"

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
