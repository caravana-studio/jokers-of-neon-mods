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
WORLD_ADDRESS=$(get_env_var "WORLD_ADDRESS")
NAMESPACE_MODS=$(get_env_var "NAMESPACE_MODS")

# Print the stored variables
# echo "Variables loaded:"
# echo "ACCOUNT_ADDRESS=$ACCOUNT_ADDRESS"
# echo "PRIVATE_KEY=$PRIVATE_KEY"
# echo "RPC_URL=$RPC_URL"
# echo "WORLD_ADDRESS=$WORLD_ADDRESS"
bash ../../scripts/replace_env.sh $ACCOUNT_ADDRESS $PRIVATE_KEY $RPC_URL

rm -f Scarb.lock

rm -rf "target"
rm -f "Scarb.lock"
rm -f "manifest_dev.json"

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
