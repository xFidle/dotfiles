#!/usr/bin/env bash

set -euo pipefail

THEME=
THEMES=(vague tokyonight)
THEMED_TOOLS=(
    "${XDG_CONFIG_HOME}/bat"
    "${XDG_CONFIG_HOME}/fzf"
    "${XDG_CONFIG_HOME}/kitty"
    "${XDG_CONFIG_HOME}/lsd"
    "${XDG_CONFIG_HOME}/nvim"
    "${XDG_CONFIG_HOME}/tmux"
)

for theme in "${THEMES[@]}"; do
    if [[ "$theme" == "$1" ]]; then
        THEME="$1"
    fi
done

if [[ -z "$THEME" ]]; then
    echo "Invalid theme '$1', use one of the following: ${THEMES[*]}" >&2
    exit 1
fi

for tool_path in "${THEMED_TOOLS[@]}"; do
    script="${tool_path}/themes/switch.sh"
    chmod +x "$script"
    "$script" "$tool_path" "$THEME" "current"
done
