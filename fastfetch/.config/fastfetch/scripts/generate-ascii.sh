#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

IMG="archaludon.png"
IMG_PATH="$SCRIPT_DIR/../logos/$IMG"
OUTPUT_PATH="$SCRIPT_DIR/../logos/"
SIZE=67

ascii-image-converter "$IMG_PATH" -C -W "$SIZE" --save-txt "$OUTPUT_PATH"
