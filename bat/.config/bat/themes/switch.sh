#!/usr/bin/env bash

BAT_PATH="$1"
THEME="$2"
CURRENT="$3"

(
    cd "$BAT_PATH/themes" || exit 1
    ln -sf "$THEME" "$CURRENT.tmTheme"
)

bat cache --build >/dev/null 2>&1
