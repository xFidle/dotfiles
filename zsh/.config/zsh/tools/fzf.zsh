#!/usr/bin/env zsh

() {
  local fzf="${XDG_CONFIG_HOME}/fzf"

  export FZF_DEFAULT_OPTS="$(cat "$fzf/config" "$fzf/themes/current")"
  export FZF_CTRL_T_OPTS="$(cat "$fzf/ctrl-t")"
  export FZF_ALT_C_OPTS="$(cat "$fzf/alt-c")"

  export FZF_DEFAULT_COMMAND="fd --type f --hidden --strip-cwd-prefix"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
}
