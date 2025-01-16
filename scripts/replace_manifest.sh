#!/bin/bash

set -e

mod_name=$1

cp -f manifest_dev.json manifest_dev_bkp.json 

# Copy manifest_dev.json to the mod directory
cp -f ../../manifest_dev.json manifest_dev.json

# Replace all occurrences of jokers_of_neon_mods- with mod_name
sed -i '' "s/jokers_of_neon_mods-/${mod_name}-/g" manifest_dev.json