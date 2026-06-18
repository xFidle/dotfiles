ZPLUGINDIR="${ZDOTDIR}/plugins"
ZPLUGINLIST="${ZDOTDIR}"

zplugin_install() {
    ## clone -> add to list
    local plugin_path="${ZPLUGINDIR}/${2}"
    if [[ ! -d "$plugin_path" ]]; then
        mkdir -p "$ZPLUGINDIR"
        if git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" >/dev/null 2>&1; then
            echo "Successfully installed ${2}"
        else
            echo "Failed to install ${2}" >&2
        fi
    fi
}

zplugin_remove() {
    echo
    ##  rm -rf {plugin}
    ## remove from list
}

zplugin_list() {
    echo
    # traverse list file, print nicely

}

zplugin_update() {
    # enable --all flag, or given name (which matches plugin_path)
    local dir old_head new_head
    for dir in "${ZPLUGINDIR}"/*/; do
        old_head="$(git -C $dir rev-parse --short HEAD)"
        if git -C "$dir" pull --ff-only >/dev/null 2>&1; then
            new_head="$(git -C $dir rev-parse --short HEAD)"
            [[ "$old_head" == "$new_head" ]] || echo "Updated ${dir:t}: $old_head -> $new_head"
        fi
    done
}

_zplugin_init() {
    source "${plugin_path}/${2}.plugin.zsh"
}

_zplugin_load zsh-users zsh-autosuggestions
_zplugin_load zsh-users zsh-history-substring-search
_zplugin_load zsh-users zsh-syntax-highlighting
_zplugin_load zsh-users zsh-completions
_zplugin_load kutsan zsh-system-clipboard
