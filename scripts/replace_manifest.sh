#!/bin/bash

set -e

profile="${1:-dev}"

cp -f manifest_dev.json manifest_dev_bkp.json

# Copy manifest_dev.json to the mod directory
cp -f ../../manifest_${profile}.json manifest_dev.json
