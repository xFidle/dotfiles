source "${ZDOTDIR}/core/aliases.zsh"
source "${ZDOTDIR}/core/bindings.zsh"
source "${ZDOTDIR}/core/options.zsh"
source "${ZDOTDIR}/core/vi-mode.zsh"

source "${ZDOTDIR}/zplugin/zplugin.zsh"

source "${ZDOTDIR}/tools/fzf.zsh"

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

precmd() { precmd() { echo; }; }
