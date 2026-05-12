#!/bin/bash

set -e

profile="${1:-dev}"
mod_name="${2:-jokers_of_neon_classic}"
core_repo_path="${3:-../jokers-of-neon-core}"
target="${4:-all}"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mods_root="$(cd "$script_dir/.." && pwd)"

if [ ! -d "$core_repo_path" ]; then
    core_repo_path="$mods_root/$core_repo_path"
fi

if [ ! -d "$core_repo_path" ]; then
    echo "⚠️  Core repo not found at $core_repo_path. Skipping core metadata refresh."
    exit 0
fi

core_repo_path="$(cd "$core_repo_path" && pwd)"

mod_path="$mods_root/mods/$mod_name"
if [ ! -d "$mod_path" ]; then
    echo "Error: Mod directory '$mod_path' does not exist"
    exit 1
fi

hex_value=$(echo -n "$mod_name" | xxd -p | tr -d '\n')
mod_id=$(python3 -c "print(int('$hex_value', 16))")

core_world_address=$(cd "$core_repo_path" && sozo -P "$profile" inspect | awk '/World/ {getline; getline; print $3}')
if [ -z "$core_world_address" ]; then
    echo "⚠️  Core world not found. Skipping core metadata refresh."
    exit 0
fi

pushd "$mod_path" > /dev/null

if [ "$target" != "rages" ] && [ -f "src/specials/specials.cairo" ]; then
    inspect_output=$(sozo inspect)
    special_names=($(echo "$inspect_output" | grep "\-special_" | awk -F'|' '{gsub(/^[ \t]+/, "", $1); print $1}' | sed 's/.*-special_//'))
    declare -a special_ids
    for special in "${special_names[@]}"; do
        special_upper=$(echo "$special" | tr '[:lower:]' '[:upper:]' | tr '-' '_')
        id=$(grep -i "^pub const SPECIAL_${special_upper}_ID" src/specials/specials.cairo | awk -F'=' '{print $2}' | awk '{print $1}' | tr -d ' ;')
        if [ -n "$id" ]; then
            special_ids+=("$id")
        fi
    done

    special_ids_str=$(IFS=,; echo "${special_ids[*]}")
    if [ -n "$special_ids_str" ]; then
        echo -e "\nRefreshing core special metadata cache..."
        (
            cd "$core_repo_path" &&
            sozo -P "$profile" execute mod_manager_registrator refresh_specials_metadata \
                $mod_id arr:$special_ids_str \
                --wait \
                --world $core_world_address
        )
    fi
fi

if [ "$target" != "specials" ] && [ -f "src/rages/rages.cairo" ]; then
    inspect_output=$(sozo inspect)
    rage_names=($(echo "$inspect_output" | grep "\-rage_" | awk -F'|' '{gsub(/^[ \t]+/, "", $1); print $1}' | sed 's/.*-rage_//'))
    declare -a rage_ids
    for rage in "${rage_names[@]}"; do
        rage_upper=$(echo "$rage" | tr '[:lower:]' '[:upper:]' | tr '-' '_')
        id=$(grep -i "^pub const RAGE_CARD_${rage_upper}" src/rages/rages.cairo | awk -F'=' '{print $2}' | tr -d ' ;')
        if [ -n "$id" ]; then
            rage_ids+=("$id")
        fi
    done

    rage_ids_str=$(IFS=,; echo "${rage_ids[*]}")
    if [ -n "$rage_ids_str" ]; then
        echo -e "\nRefreshing core rage metadata cache..."
        (
            cd "$core_repo_path" &&
            sozo -P "$profile" execute mod_manager_registrator refresh_rages_metadata \
                $mod_id arr:$rage_ids_str \
                --wait \
                --world $core_world_address
        )
    fi
fi

popd > /dev/null

echo -e "\n✅ Core metadata cache refresh finish!"
