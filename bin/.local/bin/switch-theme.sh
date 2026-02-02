#!/usr/bin/bash
set -e

THEMES=("tokyonight" "vague")

THEME=$1
CURRENT=current-theme
FILE=$HOME/.config/theme/$CURRENT

if [[ "$#" -ne 1 ]]; then
    echo "Theme name not provided" >&2
    exit 2
fi

found=false
for item in ${THEMES[@]}; do 
    if [[ "$THEME" == "$item" ]]; then
        found=true
        break
    fi
done

if ! $found ; then
    echo "Theme was not defined. Use one of following: ${THEMES[@]}" >&2
    exit 2
fi

echo $THEME > $FILE.conf 
echo "Theme '$THEME' set in config file '$FILE'" >&1

kitten themes $THEME 
echo "KITTY: theme '$THEME' set" >&1

TMUX_PATH="$HOME/.config/tmux"
ln -sf $(realpath --relative-to="$TMUX_PATH" "$TMUX_PATH/themes/$THEME.conf") \
    "$TMUX_PATH/$CURRENT.conf"
tmux source "$HOME/.config/tmux/tmux.conf"
echo "TMUX: theme '$THEME' set" >&1

if [[ -d "$NVIM_SOCKET_DIR" ]]; then
    for sock in "$NVIM_SOCKET_DIR"/*; do
        if [[ -S "$sock" ]]; then
            nvim --server $sock --remote-send ":silent colorscheme $THEME<CR>"
            echo "NVIM: theme '$THEME' set for socket '$sock'" >&1
        fi
    done
fi

FZF_PATH="$HOME/.config/fzf"
ln -sf $(realpath --relative-to="$FZF_PATH" "$FZF_PATH/themes/$THEME.conf") \
    "$FZF_PATH/$CURRENT.conf" 
echo "FZF: theme '$THEME' set" >&1

BAT_PATH="$HOME/.config/bat"
ln -sf $(realpath --relative-to="$BAT_PATH/themes" "$BAT_PATH/themes/$THEME.tmTheme") \
    "$BAT_PATH/themes/$CURRENT.tmTheme"
bat cache --build > /dev/null 2>&1
echo "BAT: theme '$THEME' set" >&1
