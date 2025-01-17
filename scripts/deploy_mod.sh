#!/bin/bash

set -e

MOD_NAME=$1

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
TORII_URL=$(get_env_var "TORII_URL")

# Print the stored variables
echo "Variables loaded:"
echo "ACCOUNT_ADDRESS=$ACCOUNT_ADDRESS"
echo "PRIVATE_KEY=$PRIVATE_KEY"
echo "RPC_URL=$RPC_URL"
echo "WORLD_ADDRESS=$WORLD_ADDRESS"
echo "TORII_URL=$TORII_URL"
bash ../../scripts/replace_env.sh $mod_name $ACCOUNT_ADDRESS $PRIVATE_KEY $RPC_URL

if [ -d "target" ]; then
    rm -rf "target"
fi

if [ -d "manifests" ]; then
    rm -rf "manifests"
fi

echo "sozo build && sozo inspect && sozo migrate"
sozo build && sozo inspect && sozo migrate

# echo -e "\n✅ deploy mod finish!"

bash ../../scripts/replace_manifest.sh $mod_name

# Create mod and store the mod_id
echo -e "\nCreating mod..."
bash ../../scripts/create_mod.sh $mod_name $ACCOUNT_ADDRESS $WORLD_ADDRESS

mod_id=$(curl -s -X POST -H "Content-Type: application/json" \
    -d '{"query":"{jokersOfNeonModsGameModModels(first: 500) {totalCount}}"}' \
    $TORII_URL/graphql | jq -r '.data.jokersOfNeonModsGameModModels.totalCount')

echo "Mod ID registered: $mod_id"
mod_id=1 # TODO: get from curl

echo -e "\nRegistering specials..."
bash ../../scripts/register_specials.sh $mod_name $mod_id $WORLD_ADDRESS

echo -e "\nRegistering rages..."
bash ../../scripts/register_rages.sh $mod_name $mod_id $WORLD_ADDRESS

echo -e "\n✅ All registrations completed!"

bash ../../scripts/restore_manifest.sh
