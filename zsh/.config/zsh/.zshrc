source "$ZDOTDIR/core/aliases.zsh"
source "$ZDOTDIR/core/bindings.zsh"
source "$ZDOTDIR/core/options.zsh"
source "$ZDOTDIR/core/plugins.zsh"
source "$ZDOTDIR/core/vi-mode.zsh"

bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

export FZF_DEFAULT_OPTS_FILE="$XDG_CONFIG_HOME/fzf/theme"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
precmd() { precmd() { echo; }; }
eval "$(starship init zsh)"
