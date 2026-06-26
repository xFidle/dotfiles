#!/usr/bin/env bash

NVIM_PATH="$1"
THEME="$2"
CURRENT="$3"

(
    cd "$NVIM_PATH/themes" || exit 1
    ln -sf "$THEME" "$CURRENT"
)

for sock in "$XDG_RUNTIME_DIR"/nvim.*; do
    if [[ -S "$sock" ]]; then
        nvim --server "$sock" --remote-send ":silent colorscheme $THEME<CR>"
    fi
done
