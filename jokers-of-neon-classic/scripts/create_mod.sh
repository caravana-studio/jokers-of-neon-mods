#!/bin/bash

set -e

# Store sozo inspect result once
inspect_result=$(sozo inspect)

# Extract addresses from the stored result
world_address=$(echo "$inspect_result" | awk '/World/ {getline; getline; print $3}')
echo "World address: $world_address"

loot_boxes_info_address=$(echo "$inspect_result" | grep "jokers_of_neon_classic-loot_boxes_info" | awk '{print $NF}')
echo "Loot Boxes Info address: $loot_boxes_info_address"

specials_info_address=$(echo "$inspect_result" | grep "jokers_of_neon_classic-specials_info" | awk '{print $NF}')
echo "Specials Info address: $specials_info_address"

sozo execute registrator_system register_game_mod -c 11,$loot_boxes_info_address,$specials_info_address --wait --world $world_address

mod_id=$(curl -s -X POST -H "Content-Type: application/json" \
    -d '{"query":"{jokersOfNeonGameModModels(first: 500) {totalCount}}"}' \
    http://localhost:8080/graphql | jq -r '.data.jokersOfNeonGameModModels.totalCount')

echo "Mod ID registered: $mod_id"
