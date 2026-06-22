#!/usr/bin/env zsh

bindkey -v

quotes=(\' \" \`)
brackets=(\( \) \{ \} \[ \] \< \>)
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in a i; do
        for q in "${quotes[@]}"; do bindkey -M "$m" "$c$q" select-quoted; done
        for b in "${brackets[@]}"; do bindkey -M "$m" "$c$b" select-bracketed; done
    done
done

zle-keymap-select() {
    case "${KEYMAP}" in
    vicmd)
        echo -ne '\e[1 q'
        ;;
    viins | main)
        echo -ne '\e[5 q'
        ;;
    esac
}

zle-line-init() {
    zle -K vicmd
    echo -ne "\e[1 q"
}

zle -N zle-keymap-select
zle -N zle-line-init
