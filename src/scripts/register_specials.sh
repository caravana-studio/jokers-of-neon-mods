#!/bin/bash

mod_id="$1"

# Change to the project root directory (where the script is located)
cd "$(dirname "$0")/.." || exit 1

# Check if specials.cairo exists
if [ ! -f "src/specials/specials.cairo" ]; then
    echo "Error: src/specials/specials.cairo not found"
    exit 1
fi

# Get project name from Scarb.toml
project_name=$(grep '^name = ' Scarb.toml | cut -d'"' -f2)

# Run sozo inspect and store output directly in a variable
inspect_output=$(sozo inspect)

# Create arrays directly
special_names=($(echo "$inspect_output" | grep "${project_name}-special_" | sed "s/${project_name}-special_\([^ ]*\).*/\1/"))
contract_addresses=($(echo "$inspect_output" | grep "${project_name}-special_" | awk '{print $NF}'))

# Create array for special IDs
declare -a special_ids
for special in "${special_names[@]}"; do
    # Convert special name to uppercase and replace hyphens with underscores
    special_upper=$(echo "$special" | tr '[:lower:]' '[:upper:]' | tr '-' '_')
    # Search for the ID in specials.cairo and get only the last number in the line
    id=$(grep -i "^const SPECIAL_${special_upper}_ID" src/specials/specials.cairo | awk -F'=' '{print $2}' | tr -d ' ;')
    if [ -n "$id" ]; then
        special_ids+=("$id")
    else
        special_ids+=("not_found")
    fi
done

# Prepare the parameters for sozo execute
len_contract_addresses=${#contract_addresses[@]}
len_special_ids=${#special_ids[@]}
special_ids_str=$(IFS=,; echo "${special_ids[*]}")
contract_addresses_str=$(IFS=,; echo "${contract_addresses[*]}" | tr -d '"')

world_address=$(sozo inspect | awk '/World/ {getline; getline; print $3}')

# Execute sozo command
echo -e "\nExecuting sozo command..."
sozo execute registrator_system register_specials -c $mod_id,$len_special_ids,$special_ids_str,$len_contract_addresses,$contract_addresses_str --wait --world $world_address
echo -e "\n✅ Register specials finish!"
