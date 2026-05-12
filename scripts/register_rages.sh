#!/bin/bash

mod_name="$1"
mod_id="$2"
world_address="$3"
namespace_mods="$4"
profile="$5"
core_repo_path="${6:-../../../jokers-of-neon-core}"

# Check if rages.cairo exists
if [ ! -f "src/rages/rages.cairo" ]; then
    echo "Error: src/rages/rages.cairo not found"
    exit 1
fi

# Run sozo inspect and store output directly in a variable
inspect_output=$(sozo inspect)

# Create arrays directly
rage_names=($(echo "$inspect_output" | grep "\-rage_" | awk -F'|' '{gsub(/^[ \t]+/, "", $1); print $1}' | sed 's/.*-rage_//'))
contract_addresses=($(echo "$inspect_output" | grep "\-rage_" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $5); print $5}'))

# Create array for special IDs
declare -a rage_ids
for rage in "${rage_names[@]}"; do
    # Convert special name to uppercase and replace hyphens with underscores
    rage_upper=$(echo "$rage" | tr '[:lower:]' '[:upper:]' | tr '-' '_')
    # Search for the ID in rages.cairo and get only the last number in the line
    id=$(grep -i "^pub const RAGE_CARD_${rage_upper}" src/rages/rages.cairo | awk -F'=' '{print $2}' | tr -d ' ;')
    if [ -n "$id" ]; then
        rage_ids+=("$id")
    else
        rage_ids+=("not_found")
    fi
done

# Prepare the parameters for sozo execute
rage_ids_str=$(IFS=,; echo "${rage_ids[*]}")
contract_addresses_str=$(IFS=,; echo "${contract_addresses[*]}" | tr -d '"')

world_address=$(sozo inspect | awk '/World/ {getline; getline; print $3}')

# Execute sozo command
# echo -e "\nExecuting sozo command..."
sozo execute $namespace_mods-rage_manager register_rages $mod_id arr:$rage_ids_str arr:$contract_addresses_str --wait --world $world_address
echo -e "\n✅ Register rages finish!"

if [ -n "$profile" ] && [ -n "$rage_ids_str" ] && [ -d "$core_repo_path" ]; then
    ../../scripts/refresh_core_metadata.sh "$profile" "$mod_name" "$core_repo_path" rages \
        || echo "⚠️  Skipped core rage metadata refresh. Core managers may not be registered yet."
fi
