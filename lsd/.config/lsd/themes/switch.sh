#!/usr/bin/env bash

LSD_PATH="$1"
THEME="$2"
CURRENT="$3"

(
    cd "$LSD_PATH/themes" || exit 1
    ln -sf "$THEME" "$CURRENT"
)
(
    cd "$LSD_PATH" || exit 1
    ln -sf "themes/$CURRENT" "colors.yaml"
)
