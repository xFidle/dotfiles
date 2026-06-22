#!/usr/bin/env bash

ZPLUGIN_SAVE_DIR="${XDG_DATA_HOME}/zplugin"
ZPLUGIN_SOURCE_DIR="${ZDOTDIR}/zplugin"
ZPLUGIN_LOCK_FILE="$ZPLUGIN_SOURCE_DIR/zplugin.lock"

# TODO: improve logging

_zplugin_resolve() {
    local _spec="$1"
    [[ $_spec =~ ^([^/]+)/([^/]+)$ ]] || return 1
    echo "${match[1]} ${match[2]} $ZPLUGIN_SAVE_DIR/${match[2]}"
}

zplugin_install() {
    local _owner _repo _plugin_path
    read -r _owner _repo _plugin_path <<<"$(_zplugin_resolve "$1")" || return 1

    [[ -d "$_plugin_path" ]] && return
    if git clone --depth=1 "https://github.com/${_owner}/${_repo}" "$_plugin_path"; then
        echo "Successfully installed ${2}"
    else
        echo "Failed to install ${2}" >&2
        return 1
    fi
}

# TODO: finish those functions

# zplugin_remove() { }
# zplugin_sync() { }
# zplugin_list() { }

zplugin_update() {
    local _repo _plugin_path _old_head _new_head
    read -r _ _repo _plugin_path <<<"$(_zplugin_resolve "$1")" || return 1

    _old_head="$(git -C "$_plugin_path" rev-parse --short HEAD)"
    if git -C "$_plugin_path" pull --ff-only >/dev/null 2>&1; then
        _new_head="$(git -C "$_plugin_path" rev-parse --short HEAD)"
        [[ "$_old_head" == "$_new_head" ]] || echo "Updated ${_repo}: $_old_head -> $_new_head"
    fi
}

zplugin_update_all() {
    while IFS=read -r _plugin; do
        zplugin_update "${_plugin}"
    done <"$ZPLUGIN_LOCK_FILE"
}

_zplugin_source() {
    local _repo _plugin_path
    read -r _ _repo _plugin_path <<<"$(_zplugin_resolve "$1")" || return 1
    source "$_plugin_path/$_repo.plugin.zsh"
}

_zplugin_init() {
    mkdir -p "$ZPLUGIN_SAVE_DIR"
    while IFS= read -r _plugin; do
        zplugin_install "$_plugin"
        _zplugin_source "$_plugin"
    done <"$ZPLUGIN_LOCK_FILE"
}

_zplugin_init
