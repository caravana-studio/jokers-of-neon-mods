#!/bin/bash

mod_id="$1"

# Change to the project root directory (where the script is located)
cd "$(dirname "$0")/.." || exit 1

# Check if rages.cairo exists
if [ ! -f "src/rages/rages.cairo" ]; then
    echo "Error: src/rages/rages.cairo not found"
    exit 1
fi

# Get project name from Scarb.toml
project_name=$(grep '^name = ' Scarb.toml | cut -d'"' -f2)

# Run sozo inspect and store output directly in a variable
inspect_output=$(sozo inspect)

# Create arrays directly
rage_names=($(echo "$inspect_output" | grep "${project_name}-rage_" | sed "s/${project_name}-rage_\([^ ]*\).*/\1/"))
contract_addresses=($(echo "$inspect_output" | grep "${project_name}-rage_" | awk '{print $NF}'))

# Create array for special IDs
declare -a rage_ids
for rage in "${rage_names[@]}"; do
    # Convert special name to uppercase and replace hyphens with underscores
    rage_upper=$(echo "$rage" | tr '[:lower:]' '[:upper:]' | tr '-' '_')
    # Search for the ID in rages.cairo and get only the last number in the line
    id=$(grep -i "^const RAGE_CARD_${rage_upper}" src/rages/rages.cairo | awk -F'=' '{print $2}' | tr -d ' ;')
    if [ -n "$id" ]; then
        rage_ids+=("$id")
    else
        rage_ids+=("not_found")
    fi
done

# Prepare the parameters for sozo execute
len_contract_addresses=${#contract_addresses[@]}
len_rage_ids=${#rage_ids[@]}
rage_ids_str=$(IFS=,; echo "${rage_ids[*]}")
contract_addresses_str=$(IFS=,; echo "${contract_addresses[*]}" | tr -d '"')

world_address=$(sozo inspect | awk '/World/ {getline; getline; print $3}')

# Execute sozo command
echo -e "\nExecuting sozo command..."
sozo execute registrator_system register_rages -c $mod_id,$len_rage_ids,$rage_ids_str,$len_contract_addresses,$contract_addresses_str --wait --world $world_address
echo -e "\n✅ Register rages finish!"
