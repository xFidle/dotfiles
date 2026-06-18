declare -A vars=(
  [XDG_CONFIG_HOME]="$HOME/.config"
  [XDG_CACHE_HOME]="$HOME/.cache"
  [XDG_DATA_HOME]="$HOME/.local/share"
  [XDG_STATE_HOME]="$HOME/.local/state"
  [ZDOTDIR]="$HOME/.config/zsh"
)

for name val in "${(@kv)vars}"; do
  [[ -n "$val" ]] && export "$name=$val"
  [[ -d "$val" ]] || mkdir -p "$val"
done
