#!/bin/bash

set -e

profile="${1:-dev}"

# Validate profile parameter
if [ "$profile" != "dev" ] && [ "$profile" != "aws-testnet" ] && [ "$profile" != "aws-mainnet" ]; then
    echo "Error: Invalid profile. Please use 'dev', 'aws-testnet', or 'aws-mainnet'."
    exit 1
fi

echo "Deploying in ${profile}."

# Clean up build artifacts
echo "Cleaning up build artifacts..."
rm -rf "target"
[ -f "./Scarb.lock" ] && rm "./Scarb.lock"

# Remove corresponding manifest file
manifest_file="manifest_${profile}.json"
if [ -f "$manifest_file" ]; then
    echo "Removing manifest file: $manifest_file"
    rm -f "$manifest_file"
fi

echo "sozo build && sozo inspect && sozo migrate"
sozo -P ${profile} build && sozo -P ${profile} inspect && sozo -P ${profile} migrate

echo -e "\n✅ Deployed!"
