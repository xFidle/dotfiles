_fzf() {
  local fzf="${XDG_CONFIG_HOME}/fzf"
  export FZF_DEFAULT_OPTS="$(cat "$fzf/config" "$fzf/themes/current")"
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=plain,numbers {}'"
  export FZF_ALT_C_OPTS="--preview 'lsd --tree --color=always --icon=always {}'"
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --strip-cwd-prefix --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
}

_fzf-tab() {
  zstyle ':fzf-tab:*' use-fzf-default-opts yes
  zstyle ':fzf-tab:*' show-group brief
  zstyle ':completion:*:descriptions' format '[%d]'
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --tree --color=always --icon=always {}'
}

_fzf && _fzf-tab
