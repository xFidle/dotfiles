#!/usr/bin/env bash

KITTY_PATH="$1"
THEME="$2"
CURRENT="$3"

(
    cd "$KITTY_PATH/themes" || exit 1
    ln -sf "$THEME" "$CURRENT"
)

kill -SIGUSR1 $(pgrep kitty)
