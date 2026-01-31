#!/usr/bin/bash
set -e

THEMES=("tokyonight" "vague")

theme=$1
current=current-theme
file=$HOME/.config/theme/$current


if [[ "$#" -ne 1 ]]; then
    echo "Theme name not provided" >&2
    exit 2
fi

found=false
for item in ${THEMES[@]}; do 
    if [[ "$theme" == "$item" ]]; then
        found=true
        break
    fi
done

if ! $found ; then
    echo "Theme was not defined. Use one of following: ${THEMES[@]}" >&2
    exit 2
fi

echo $theme > $file.conf 
echo "Theme '$theme' set in config file '$file'" >&1

kitten themes $theme
echo "KITTY: theme '$theme' set" >&1

ln -sf $(realpath --relative-to="$HOME/.config/tmux" "$HOME/.config/tmux/themes/$theme.conf") \
    "$HOME/.config/tmux/$current.conf"
tmux source "$HOME/.config/tmux/tmux.conf"
echo "TMUX: theme '$theme' set" >&1

if [[ -S "$NVIM_SOCKET" ]]; then
    nvim --server $NVIM_SOCKET --remote-send ":colorscheme $theme<CR>"
    echo "NVIM: theme '$theme' set" >&1
fi

ln -sf $(realpath --relative-to="$HOME/.config/fzf" "$HOME/.config/fzf/themes/$theme.conf") \
    "$HOME/.config/fzf/$current.conf" 
echo "FZF: theme '$theme' set" >&1

ln -sf $(realpath --relative-to="$HOME/.config/bat/themes" "$HOME/.config/bat/themes/$theme.tmTheme") \
    "$HOME/.config/bat/themes/$current.tmTheme"
bat cache --build > /dev/null 2>&1
echo "BAT: theme '$theme' set" >&1
