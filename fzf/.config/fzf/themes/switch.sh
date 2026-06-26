#!/usr/bin/env bash

FZF_PATH="$1"
THEME="$2"
CURRENT="$3"

(
    cd "$FZF_PATH/themes" || exit 1
    ln -sf "$THEME" "$CURRENT"
)

echo "FZF: '$THEME' set"
