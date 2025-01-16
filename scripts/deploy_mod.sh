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

bash ../../scripts/replace_env.sh $mod_name

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
bash ../../scripts/create_mod.sh $mod_name

mod_id=$(curl -s -X POST -H "Content-Type: application/json" \
    -d '{"query":"{jokersOfNeonModsGameModModels(first: 500) {totalCount}}"}' \
    http://localhost:8080/graphql | jq -r '.data.jokersOfNeonModsGameModModels.totalCount')

echo "Mod ID registered: $mod_id"

echo -e "\nRegistering specials..."
bash ../../scripts/register_specials.sh $mod_name $mod_id

echo -e "\nRegistering rages..."
bash ../../scripts/register_rages.sh $mod_name $mod_id

echo -e "\n✅ All registrations completed!"

bash ../../scripts/restore_manifest.sh
