#!/bin/bash

set -e

# Get all mod directories
mod_dirs=($(ls -d mods/*))

# Loop through each mod directory and extract the mod name
for mod_dir in "${mod_dirs[@]}"; do
    # Extract just the mod name from the path
    mod_name=$(basename "$mod_dir")
    
    echo "Deploying mod: $mod_name"
    make deploy-mod mod_name=$mod_name
    
    # Add a small delay between deployments
    sleep 2
    
    echo "----------------------------------------"
done

echo "✅ All mods have been deployed!"
