#!/bin/bash

set -e

profile="${1:-dev}"

cp -f manifest_dev_bkp.json manifest_dev.json

rm manifest_dev_bkp.json
