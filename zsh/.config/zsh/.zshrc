CORE="$ZDOTDIR/core"
ZPLUGIN="$ZDOTDIR/zplugin"

source "$CORE/aliases.zsh"
source "$CORE/bindings.zsh"
source "$CORE/options.zsh"
source "$CORE/vi-mode.zsh"
source "$ZPLUGIN/zplugin.zsh"

bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

export FZF_DEFAULT_OPTS_FILE="$XDG_CONFIG_HOME/fzf/theme"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
precmd() { precmd() { echo; }; }
eval "$(starship init zsh)"
