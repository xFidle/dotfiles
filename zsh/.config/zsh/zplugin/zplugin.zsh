#!/usr/bin/env bash

ZPLUGIN_LOCKFILE="${ZDOTDIR}/zplugin/zplugin.lock"
ZPLUGIN_SAVE_DIR="${XDG_DATA_HOME}/zplugin"
ZPLUGIN_DEFAULT_PLUGINS=(
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-completions
)

zplugin_install() {
    local _plugin _plugin_save_path
    _plugin="$1"
    _plugin_save_path="$ZPLUGIN_SAVE_DIR/$_plugin"

    [[ -d "$_plugin_save_path" ]] && return
    if git clone --depth=1 "https://github.com/$_plugin" "$_plugin_save_path" >/dev/null 2>&1; then
        echo "Successfully installed ${_plugin}"
    else
        echo "Failed to install ${_plugin}" >&2
        return 1
    fi
}

zplugin_update() {
    local _plugin _plugin_save_path _old_head _new_head
    _plugin="$1"
    _plugin_save_path="$ZPLUGIN_SAVE_DIR/$_plugin"

    _old_head="$(git -C "$_plugin_save_path" rev-parse --short HEAD)"
    if git -C "$_plugin_save_path" pull --ff-only >/dev/null 2>&1; then
        _new_head="$(git -C "$_plugin_save_path" rev-parse --short HEAD)"
        [[ "$_old_head" == "$_new_head" ]] || echo "Updated ${_plugin}: $_old_head -> $_new_head"
    fi
}

_zplugin_validate() {
    local _plugin="$1"
    if [[ ! "$1" =~ ^([^/]+)/([^/]+)$ ]]; then
        echo "Plugin name ($_plugin) is not in format <owner>/<repo>"
    fi
}

_zplugin_source_lockfile() {
    local _plugin
    while read -r _plugin _ _; do
        local _name="${_plugin:t}"
        source "$ZPLUGIN_SAVE_DIR/$_plugin/$_name.plugin.zsh"
    done <"$ZPLUGIN_LOCKFILE"
}

_zplugin_sync() {
    local _dir _plugin _commit _branch _rows=()
    for _dir in "$ZPLUGIN_SAVE_DIR"/*/*/; do
        [[ -d "$_dir/.git" ]] || continue
        _plugin="${_dir:h:t}/${_dir:t}"
        _branch="$(git -C "$_dir" rev-parse --abbrev-ref HEAD 2>/dev/null)"
        _commit="$(git -C "$_dir" rev-parse HEAD 2>/dev/null)"
        _rows+=("$_plugin $_branch $_commit")
    done
    print -l -- "${_rows[@]}" | column -t >>"$ZPLUGIN_LOCKFILE"
}

_zplugin_restore_lockfile() {
    local _plugin _branch _commit
    while read -r _plugin _branch _commit; do
        zplugin_install "$_plugin"
    done <"$ZPLUGIN_LOCKFILE"
}

_zplugin_restore_default() {
    local _plugin
    for _plugin in "${ZPLUGIN_DEFAULT_PLUGINS[@]}"; do
        zplugin_install "$_plugin"
    done
}

_zplugin_init() {
    if [[ -f "$ZPLUGIN_LOCKFILE" ]]; then
        _zplugin_restore_lockfile
    else
        _zplugin_restore_default
        _zplugin_sync
    fi

    _zplugin_source_lockfile
}

_zplugin_init
