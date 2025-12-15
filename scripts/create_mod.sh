#!/bin/bash

set -e

mod_name=$1
owner=$2
world_address=$3
mod_id=$4
namespace_mods="${5:-jokers_of_neon_mods}"

# Store sozo inspect result once
inspect_result=$(sozo inspect)

# echo "mod_name: $mod_name"
# echo "inspect_result: $inspect_result"

card_info_address=$(echo "$inspect_result" | grep "\-card_info" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $5); print $5}')
# echo "Card Info address: $card_info_address"

loot_boxes_info_address=$(echo "$inspect_result" | grep "\-loot_boxes_info" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $5); print $5}')
# echo "Loot Boxes Info address: $loot_boxes_info_address"

rages_info_address=$(echo "$inspect_result" | grep "\-rages_info" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $5); print $5}')
# echo "Rages Info address: $rages_info_address"

specials_info_address=$(echo "$inspect_result" | grep "\-specials_info" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $5); print $5}')
# echo "Specials Info address: $specials_info_address"

game_config_address=$(echo "$inspect_result" | grep "\-game_config" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $5); print $5}')
# echo "Game Config address: $game_config_address"

shop_config_address=$(echo "$inspect_result" | grep "\-shop_config" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $5); print $5}')
# echo "Shop Config address: $shop_config_address"

poker_hands_info_address=$(echo "$inspect_result" | grep "\-poker_hands_info" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $5); print $5}')
# echo "Poker Hands Info address: $poker_hands_info_address"

sozo execute $namespace_mods-mod_manager create_mod $owner $mod_id 0 $card_info_address $specials_info_address $rages_info_address $loot_boxes_info_address $game_config_address $shop_config_address $poker_hands_info_address --wait --world $world_address
