#!/bin/bash

set -e

profile="${1:-dev}"
mod_name="${2:-jokers_of_neon_classic}"

# Validate profile parameter
if [ "$profile" != "dev" ] && [ "$profile" != "slot" ] && [ "$profile" != "testnet" ] && [ "$profile" != "mainnet" ]; then
    echo "Error: Invalid profile. Please use 'dev', 'slot', 'testnet', or 'mainnet'."
    exit 1
fi

# Check if mod directory exists
if [ ! -d "mods/$mod_name" ]; then
    echo "Error: Mod directory 'mods/$mod_name' does not exist"
    exit 1
fi

# Change to mod directory
cd "mods/$mod_name"

TOML_FILE="../../dojo_${profile}.toml"

# Check if TOML file exists
if [ ! -f "$TOML_FILE" ]; then
    echo "Error: Configuration file $TOML_FILE not found"
    exit 1
fi

# Function to get value from TOML file
get_toml_value() {
    local key=$1
    local value=$(grep "^${key} =" "$TOML_FILE" | sed 's/.*= *"\(.*\)".*/\1/')

    if [ -z "$value" ]; then
        echo "Error: $key not found in $TOML_FILE"
        exit 1
    fi
    echo "$value"
}

# Store variables from TOML
ACCOUNT_ADDRESS=$(get_toml_value "account_address")
PRIVATE_KEY=$(get_toml_value "private_key")
RPC_URL=$(get_toml_value "rpc_url")
NAMESPACE_MODS=$(get_toml_value "default")
WORLD_ADDRESS=$(sozo -P ${profile} inspect | awk '/World/ {getline; getline; print $3}')

# Print the stored variables
# echo "Variables loaded:"
# echo "ACCOUNT_ADDRESS=$ACCOUNT_ADDRESS"
# echo "PRIVATE_KEY=$PRIVATE_KEY"
# echo "RPC_URL=$RPC_URL"
# echo "WORLD_ADDRESS=$WORLD_ADDRESS"
bash ../../scripts/replace_env.sh $ACCOUNT_ADDRESS $PRIVATE_KEY $RPC_URL

rm -rf "target"
rm -f "manifest_dev.json"
[ -f "./Scarb.lock" ] && rm "./Scarb.lock"

echo "Deploying in ${profile}."
echo "Deploying mod: ${mod_name}"

sozo build && sozo inspect && sozo migrate
# sozo build && sozo inspect && sozo migrate --fee ETH

# echo -e "\n✅ deploy mod finish!"

bash ../../scripts/replace_manifest.sh $profile

hex_value=$(echo -n "$mod_name" | xxd -p | tr -d '\n')
mod_id=$(python3 -c "print(int('$hex_value', 16))")

echo -e "\nCreating mod..."
bash ../../scripts/create_mod.sh $mod_name $ACCOUNT_ADDRESS $WORLD_ADDRESS $mod_id $NAMESPACE_MODS

echo -e "\nRegistering specials..."
bash ../../scripts/register_specials.sh $mod_name $mod_id $WORLD_ADDRESS $NAMESPACE_MODS

echo -e "\nRegistering rages..."
bash ../../scripts/register_rages.sh $mod_name $mod_id $WORLD_ADDRESS $NAMESPACE_MODS

echo -e "\n✅ All registrations completed!"

bash ../../scripts/restore_manifest.sh

echo "Mod ID registered: $mod_name"
