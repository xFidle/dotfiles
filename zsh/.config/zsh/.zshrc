export ZSH="$HOME/.oh-my-zsh"

# plugins
plugins=(git colored-man-pages zsh-syntax-highlighting zsh-autosuggestions)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit

source "$ZSH/oh-my-zsh.sh"

# go
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Neovim setup
export EDITOR='nvim'
export VISUAL='nvim'

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

# ci', ci", ci`
autoload -U select-quoted
zle -N select-quoted
quotes=(\' \" \`)
for m in visual viopp; do
  for c in a i; do 
    for q in ${quotes[@]}; do
      bindkey -M $m "$c$q" select-quoted
    done
  done
done

# ci{, ci(, ci<, di{
autoload -U select-bracketed
zle -N select-bracketed
brackets=(\( \) \{ \} \[ \] \< \>)
for m in visual viopp; do
  for c in a i; do 
    for b in ${brackets[@]}; do
       bindkey -M $m "$c$b" select-bracketed
    done
  done
done

zle -N zle-keymap-select
zle-line-init() {
    zle -K vicmd  
    echo -ne "\e[1 q"
}
zle -N zle-line-init
echo -ne '\e[1 q' 
preexec() { echo -ne '\e[1 q' ;} 

# Newlines between prompts
PROMPT_NEEDS_NEWLINE=false
precmd() {
  if [[ "$PROMPT_NEEDS_NEWLINE" == true ]]; then
    echo
  fi
  PROMPT_NEEDS_NEWLINE=true
}
clear() {
  PROMPT_NEEDS_NEWLINE=false
  command clear
}

# Aliases
alias cat='bat --paging=never'
alias ls='lsd'
alias vim='nvim'

# History
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

# Keybindings
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# fzf
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/.fzfrc"
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow,hidden'
source <(fzf --zsh)

eval "$(zoxide init zsh)"

# Starship init
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

. "$HOME/.local/bin/env"
