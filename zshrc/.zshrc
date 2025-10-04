export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

plugins=(git zsh-syntax-highlighting zsh-autosuggestions colored-man-pages)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit

source "$ZSH/oh-my-zsh.sh"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

# pnpm
export PNPM_HOME="/home/michau/.local/share/pnpm"
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

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
quotes=('\', '"', '\`')
for m in visual viopp; do
  for c in {a,i}$quotes; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
brackets=('(', ')', '[', ']', '{', '}', '<', '>', 'b', 'B')
for m in visual viopp; do
  for c in {a,i}$brackets; do
    bindkey -M $m $c select-bracketed
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

# Aliases
alias vim="nvim"
if command -v batcat >/dev/null 2>&1; then
    _batcmd="batcat"
elif command -v bat >/dev/null 2>&1; then
    _batcmd="bat"
else
    _batcmd="cat"  # fallback if neither is installed
fi
alias bat="$_batcmd"
alias cat="$_batcmd --paging=never --style=numbers,changes"
alias ls="lsd --group-directories-first"
alias fzf=fzf --preview="bat --color=always {}"
alias npm="pnpm"
alias q="exit"

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

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
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
bindkey '^f' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey -v '^?' backward-delete-char


# fzf
source <(fzf --zsh)

# Starship init
eval "$(starship init zsh)"


