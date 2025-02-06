#!/bin/bash

set -e

mod_name=$1
owner=$2
world_address=$3
mod_id=$4

# Store sozo inspect result once
inspect_result=$(sozo inspect)

# echo "mod_name: $mod_name"
# echo "inspect_result: $inspect_result"

card_info_address=$(echo "$inspect_result" | grep "${mod_name}-card_info" | awk '{print $NF}')
# echo "Card Info address: $card_info_address"

loot_boxes_info_address=$(echo "$inspect_result" | grep "${mod_name}-loot_boxes_info" | awk '{print $NF}')
# echo "Loot Boxes Info address: $loot_boxes_info_address"

rages_info_address=$(echo "$inspect_result" | grep "${mod_name}-rages_info" | awk '{print $NF}')
# echo "Rages Info address: $rages_info_address"

specials_info_address=$(echo "$inspect_result" | grep "${mod_name}-specials_info" | awk '{print $NF}')
# echo "Specials Info address: $specials_info_address"

game_config_address=$(echo "$inspect_result" | grep "${mod_name}-game_config" | awk '{print $NF}')
# echo "Game Config address: $game_config_address"

shop_config_address=$(echo "$inspect_result" | grep "${mod_name}-shop_config" | awk '{print $NF}')
# echo "Shop Config address: $shop_config_address"

sozo execute mod_manager create_mod $owner $mod_id 0 $card_info_address $specials_info_address $rages_info_address $loot_boxes_info_address $game_config_address $shop_config_address --wait --world $world_address
