#!/bin/bash

set -e

if [ -d "target" ]; then
    rm -rf "target"
fi

if [ -d "manifests" ]; then
    rm -rf "manifests"
fi

echo "sozo build && sozo inspect && sozo migrate"
sozo build && sozo inspect && sozo migrate

echo -e "\n✅ Setup finish!"

# Store sozo inspect result once
inspect_result=$(sozo inspect)

mod_manager_address=$(echo "$inspect_result" | grep "jokers_of_neon_mods_v18-mod_manager" | awk '{print $NF}')
rage_manager_address=$(echo "$inspect_result" | grep "jokers_of_neon_mods_v18-rage_manager" | awk '{print $NF}')
special_manager_address=$(echo "$inspect_result" | grep "jokers_of_neon_mods_v18-special_manager" | awk '{print $NF}')

echo "Execute in Jokers of Neon Contracts. Update the world address."
echo "sozo execute mod_manager_registrator register_managers $mod_manager_address $rage_manager_address $special_manager_address --wait --world world_address"
