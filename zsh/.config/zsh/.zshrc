export ZSH="$HOME/.oh-my-zsh"
export ZSH_CONFIG="$HOME/.config/zsh"
export EDITOR='nvim'
export VISUAL='nvim'

plugins=(git colored-man-pages zsh-syntax-highlighting zsh-autosuggestions zsh-system-clipboard)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit
source "$ZSH/oh-my-zsh.sh"

source "$ZSH_CONFIG/.zsh-devtools"
source "$ZSH_CONFIG/.zsh-vi"
source "$ZSH_CONFIG/.zsh-tools"
source "$ZSH_CONFIG/.zsh-prompt"

alias cat='bat --paging=never'
alias ls='lsd'
alias vi='nvim'
alias vim='nvim'
alias opencode='opencode --port'

HISTSIZE=5000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

eval "$(zoxide init zsh)"

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

. "$HOME/.local/bin/env"
