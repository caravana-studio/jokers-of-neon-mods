#!/bin/bash

action="$1"

echo "Deploying Sepolia"

set -e

rm -rf "target"
rm -rf "manifests"
rm -rf "abis"

echo "sozo -P sepolia build && sozo -P sepolia inspect && sozo -P sepolia migrate"
sozo -P sepolia build && sozo -P sepolia inspect && sozo -P sepolia migrate --fee ETH
