#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

IMG="archaludon.png"
IMG_PATH="$SCRIPT_DIR/../logos/$IMG"
OUTPUT_PATH="$SCRIPT_DIR/../logos/${IMG%.*}-colored-ascii-art.txt"
SIZE=60

# Generates logos/winter-chillet-ascii-art.txt with original colors
ascii-image-converter "$IMG_PATH" -C -W "$SIZE" > "$OUTPUT_PATH"
