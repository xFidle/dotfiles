#!/usr/bin/env bash

TMUX_PATH="$1"
THEME="$2"
CURRENT="$3"

(
    cd "$TMUX_PATH/themes" || exit
    ln -sf "$THEME" "$CURRENT"
)

tmux source "$TMUX_PATH/tmux.conf"
