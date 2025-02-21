#!/bin/bash

set -e

if [ -d "target" ]; then
    rm -rf "target"
fi

if [ -d "manifests" ]; then
    rm -rf "manifests"
fi

echo "sozo build && sozo inspect && sozo migrate"
sozo build && sleep 3 && sozo inspect && sleep 3 && sozo migrate

echo -e "\n✅ Setup finish!"

# Store sozo inspect result once
inspect_result=$(sozo inspect)

mod_manager_address=$(echo "$inspect_result" | grep "jokers_of_neon_mods-mod_manager" | awk '{print $NF}')
rage_manager_address=$(echo "$inspect_result" | grep "jokers_of_neon_mods-rage_manager" | awk '{print $NF}')
special_manager_address=$(echo "$inspect_result" | grep "jokers_of_neon_mods-special_manager" | awk '{print $NF}')

echo "Execute in Jokers of Neon Contracts. Update the world address."
echo "sozo execute mod_manager_registrator register_managers -c $mod_manager_address,$rage_manager_address,$special_manager_address --wait --world world_address"
