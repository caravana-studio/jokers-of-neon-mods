#!/bin/bash

set -e

profile="${1:-dev}"

cp -f manifest_${profile}.json manifest_${profile}_bkp.json 

# Copy manifest_dev.json to the mod directory
cp -f ../../manifest_${profile}.json manifest_${profile}.json
