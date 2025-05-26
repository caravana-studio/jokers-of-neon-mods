#!/bin/bash

set -e

cp -f manifest_dev.json manifest_dev_bkp.json 

# Copy manifest_dev.json to the mod directory
cp -f ../../manifest_dev.json manifest_dev.json