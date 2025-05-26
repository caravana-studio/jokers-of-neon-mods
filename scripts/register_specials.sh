#!/bin/bash

mod_name="$1"
mod_id="$2"
world_address="$3"
namespace_mods="$4"

# Check if specials.cairo exists
if [ ! -f "src/specials/specials.cairo" ]; then
    echo "Error: src/specials/specials.cairo not found"
    exit 1
fi

# Run sozo inspect and store output directly in a variable
inspect_output=$(sozo inspect)

# Create arrays directly
special_names=($(echo "$inspect_output" | grep "\-special_" | awk -F'|' '{gsub(/^[ \t]+/, "", $1); print $1}' | sed 's/.*-special_//'))
contract_addresses=($(echo "$inspect_output" | grep "\-special_" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $5); print $5}'))

# Create array for special IDs
declare -a special_ids
for special in "${special_names[@]}"; do
    # Convert special name to uppercase and replace hyphens with underscores
    special_upper=$(echo "$special" | tr '[:lower:]' '[:upper:]' | tr '-' '_')
    # Search for the ID in specials.cairo and get only the last number in the line
    id=$(grep -i "^const SPECIAL_${special_upper}_ID" src/specials/specials.cairo | awk -F'=' '{print $2}' | awk '{print $1}' | tr -d ' ;')
    if [ -n "$id" ]; then
        special_ids+=("$id")
    else
        special_ids+=("not_found")
    fi
done

# Prepare the parameters for sozo execute
special_ids_str=$(IFS=,; echo "${special_ids[*]}")
contract_addresses_str=$(IFS=,; echo "${contract_addresses[*]}" | tr -d '"')

world_address=$(sozo inspect | awk '/World/ {getline; getline; print $3}')

# Execute sozo command
# echo -e "\nExecuting sozo command..."
sozo execute $namespace_mods-special_manager register_specials $mod_id arr:$special_ids_str arr:$contract_addresses_str --wait --world $world_address
echo -e "\n✅ Register specials finish!"
