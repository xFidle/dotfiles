_setup_completions() {
    local COMPLETIONS_DIR="${XDG_DATA_HOME}/zsh/completions/"
    [[ -d "$COMPLETIONS_DIR" ]] || mkdir -p "$COMPLETIONS_DIR"

    if command -v rustup >/dev/null 2>&1; then
        local _rustup="$COMPLETIONS_DIR/_rustup"
        local _cargo="$COMPLETIONS_DIR/_cargo"
        [[ -f "$_rustup" ]] || rustup completions zsh >"$_rustup"
        [[ -f "$_cargo" ]] || rustup completions zsh cargo >"$_cargo"
    fi

    if command -v uv >/dev/null 2>&1; then
        local _uv="$COMPLETIONS_DIR/_uv"
        [[ -f "$_uv" ]] || uv generate-shell-completion zsh >"$_uv"
    fi

    if command -v pnpm >/dev/null 2>&1; then
        local _pnpm="$COMPLETIONS_DIR/_pnpm"
        [[ -f "$_pnpm" ]] || pnpm completion zsh >"$_pnpm"
    fi

    fpath=("$COMPLETIONS_DIR" $fpath)
    autoload -U compinit
    compinit -d "${XDG_DATA_HOME}/zsh/.zcompdump"
}

_setup_completions
