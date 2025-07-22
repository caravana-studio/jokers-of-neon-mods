#!/bin/bash

set -e

profile="${1:-dev}"

cp -f manifest_${profile}_bkp.json manifest_${profile}.json

rm manifest_${profile}_bkp.json
