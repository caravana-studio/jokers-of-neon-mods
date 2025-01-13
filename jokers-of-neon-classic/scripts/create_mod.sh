#!/bin/bash

set -e

world_address=$(sozo inspect | awk '/World/ {getline; getline; print $3}')
echo "World address: $world_address"

sozo execute registrator_system register_game_mod -c 11 --wait --world $world_address

mod_id=$(curl -s -X POST -H "Content-Type: application/json" \
    -d '{"query":"{jokersOfNeonGameModModels(first: 500) {totalCount}}"}' \
    http://localhost:8080/graphql | jq -r '.data.jokersOfNeonGameModModels.totalCount')

echo "Mod ID registered: $mod_id"
