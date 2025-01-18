#!/bin/bash

set -e

rm -rf "target"
rm -rf "manifests"
rm -rf "abis"


echo "sozo build && sozo inspect && sozo migrate"
sozo -P prod build && sozo -P prod inspect && sozo -P prod migrate

echo -e "\n✅ Setup finish!"

