#!/bin/bash

set -e

mod_name=$1

# Store sozo inspect result once
inspect_result=$(sozo inspect)

echo "mod_name: $mod_name"
echo "inspect_result: $inspect_result"

owner=0x127fd5f1fe78a71f8bcd1fec63e3fe2f0486b6ecd5c86a0466c3a21fa5cfcec # TODO: get from env
world_address=0x065ce175b71709c8353b8575f190785b2b123590e9e90be4c4399257ce3ab709 # TODO: get from env

card_info_address=$(echo "$inspect_result" | grep "${mod_name}-card_info" | awk '{print $NF}')
echo "Card Info address: $card_info_address"

loot_boxes_info_address=$(echo "$inspect_result" | grep "${mod_name}-loot_boxes_info" | awk '{print $NF}')
echo "Loot Boxes Info address: $loot_boxes_info_address"

rages_info_address=$(echo "$inspect_result" | grep "${mod_name}-rages_info" | awk '{print $NF}')
echo "Rages Info address: $rages_info_address"

specials_info_address=$(echo "$inspect_result" | grep "${mod_name}-specials_info" | awk '{print $NF}')
echo "Specials Info address: $specials_info_address"

game_config_address=$(echo "$inspect_result" | grep "${mod_name}-game_config" | awk '{print $NF}')
echo "Game Config address: $game_config_address"

shop_config_address=$(echo "$inspect_result" | grep "${mod_name}-shop_config" | awk '{print $NF}')
echo "Shop Config address: $shop_config_address"

sozo execute mod_manager create_mod -c $owner,1,0,$card_info_address,$specials_info_address,$rages_info_address,$loot_boxes_info_address,$game_config_address,$shop_config_address --wait --world $world_address
