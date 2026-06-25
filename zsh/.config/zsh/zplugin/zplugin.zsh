#!/usr/bin/env bash

ZPLUGIN_LOCKFILE="${ZDOTDIR}/zplugin/zplugin.lock"
ZPLUGIN_SAVE_DIR="${XDG_DATA_HOME}/zplugin"
ZPLUGIN_DEFAULT_PLUGINS=(
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-completions
) # Defaults are considered only if lockfile is not present

_zplugin_usage() {
    cat <<'EOF'
ZPLUGIN
A minimal zsh plugin manager.

usage: zplugin [-v|--verbose -d|--dry-run] [--] <command> [args] 

commands:
    install <plugin> [-c|--commit <sha>] clone a plugin and at it to lockfile
    update  <plugin> [-c|--commit <sha>] update one plugin, or all if plugin omitted
    remove  <plugin> [-y|--yes]          delete a plugin and drop it from the lockfile
    list             [-b|--bat]          list installed plugins
    help                                 show this message

options:
    -v, --verbose                        show detailed output to both logs and stdout
    -d, --dry-run                        show what would happen without making changes 

<plugin> is in <owner/repo> format, e.g. zsh-users/zsh-autosuggestions 
EOF
}

zplugin() {
    local ZPLUGIN_VERBOSE ZPLUGIN_DRY_RUN _operation
    while [[ "$1" == -* ]]; do
        case "$1" in
        --help | -h)
            _zplugin_usage
            return 0
            ;;
        --verbose | -v)
            ZPLUGIN_VERBOSE=true
            shift
            ;;
        --dry-run | -d)
            ZPLUGIN_DRY_RUN=true
            shift
            ;;
        --)
            shift
            break
            ;;
        -*)
            echo "Unknown global flag" >&2
            _zplugin_usage >&2
            return 1
            ;;
        esac
    done

    _operation="$1"
    shift

    case "$_operation" in
    install)
        _zplugin_install "$@" && _zplugin_sync
        ;;
    update)
        _zplugin_update "$@" && _zplugin_sync
        ;;
    remove)
        _zplugin_remove "$@" && _zplugin_sync
        ;;
    list)
        _zplugin_list
        ;;
    *)
        printf "Invalid command %s\n" "$_operation" >&2
        _zplugin_usage >&2
        return 1
        ;;
    esac
}

_zplugin_install() {
    local _plugin _dir _commit
    local _opts=(--depth=1)

    _plugin="$1"
    _zplugin_validate "$_plugin" || return 1
    shift

    while [[ $# -ne 0 ]]; do
        case "$1" in
        --commit | -c)
            _commit="${2:-}"
            if [[ -z "$_commit" ]]; then
                echo "--commit flag requries argument" >&2
                return 1
            fi
            shift 2
            ;;
        *)
            echo "Unknown flag: $1" >&2
            _zplugin_usage >&2
            return 1
            ;;
        esac
    done

    _dir="$ZPLUGIN_SAVE_DIR/$_plugin"
    [[ ! -d "$_dir" ]] || return 0
    [[ -n "$_commit" ]] && _opts+=(--revision "$_commit")
    [[ -z "$ZPLUGIN_VERBOSE" ]] && _opts+=(--quiet)

    git clone "${_opts[@]}" "https://github.com/$_plugin" "$_dir" >/dev/null 2>&1
}

_zplugin_update() {
    local _plugin="$1"
    if [[ -n "$_plugin" ]]; then
        _zplugin_update_single "$@"
    else
        _zplugin_update_all
    fi
}

_zplugin_update_single() {
    local _plugin _commit

    _plugin="$1"
    _zplugin_validate "$_plugin" || return 1
    shift

    while [[ $# -ne 0 ]]; do
        case "$1" in
        --commit | -c)
            _commit="${2:-}"
            if [[ -z "$_commit" ]]; then
                echo "--commit flag requries argument" >&2
                return 1
            fi
            shift 2
            ;;
        *)
            echo "Unknown flag: $1" >&2
            _zplugin_usage >&2
            return 1
            ;;
        esac
    done

    _dir="$ZPLUGIN_SAVE_DIR/$_plugin"
    _old_head="$(git -C "$_dir" rev-parse HEAD)"
    if [[ -n "$_commit" ]]; then
        git -C "$_dir" fetch --depth=1 origin "$_commit" || return 1
        git -C "$_dir" checkout --detach "$_commit" || return 1
    else
        git -C "$_dir" pull --ff-only || return 1
    fi
    _new_head="$(git -C "$_dir" rev-parse HEAD)"
    [[ "$_old_head" == "$_new_head" ]] || echo "Updated ${_plugin}: $_old_head -> $_new_head"
}

_zplugin_update_all() {
    local _plugin
    while read -r _plugin _; do
        _zplugin_update_single "$_plugin"
    done <"$ZPLUGIN_LOCKFILE"
}

_zplugin_remove() {
    local _plugin _dir

    _plugin="$1"
    _zplugin_validate "$_plugin" || return 1
    shift

    _dir="$ZPLUGIN_SAVE_DIR/$_plugin"
    if [[ ! -d "$_dir" ]]; then
        echo "Plugin $_plugin is not installed"
    fi

    rm -rf "$(dirname $_dir)"
}

_zplugin_list() {
    cat "$ZPLUGIN_LOCKFILE"
}

_zplugin_validate() {
    local _plugin="$1"
    if [[ ! "$1" =~ ^([^/]+)/([^/]+)$ ]]; then
        echo "Plugin name ($_plugin) is not in format <owner>/<repo>" >&2
        return 1
    fi
}

_zplugin_source_lockfile() {
    local _plugin
    while read -r _plugin _; do
        local _name="${_plugin:t}"
        source "$ZPLUGIN_SAVE_DIR/$_plugin/$_name.plugin.zsh"
    done <"$ZPLUGIN_LOCKFILE"
}

_zplugin_sync() {
    local _dir _plugin _commit _tmp
    local _rows=()
    _tmp=$(mktemp)
    for _dir in "$ZPLUGIN_SAVE_DIR"/*/*/; do
        [[ -d "$_dir/.git" ]] || continue
        _plugin="${_dir:h:t}/${_dir:t}"
        _commit="$(git -C "$_dir" rev-parse HEAD 2>/dev/null)"
        _rows+=("$_plugin  $_commit")
    done
    print -l -- "${_rows[@]}" | column -t >>"$_tmp"
    mv "$_tmp" "$ZPLUGIN_LOCKFILE"
}

_zplugin_restore_lockfile() {
    local _plugin _commit
    while read -r _plugin _commit; do
        _zplugin_install "$_plugin" --commit "$_commit"
    done <"$ZPLUGIN_LOCKFILE"
}

_zplugin_restore_default() {
    local _plugin
    for _plugin in "${ZPLUGIN_DEFAULT_PLUGINS[@]}"; do
        _zplugin_install "$_plugin"
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
