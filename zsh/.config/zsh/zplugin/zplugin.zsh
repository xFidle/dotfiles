#!/usr/bin/env bash

ZPLUGIN_LOCKFILE="${ZDOTDIR}/zplugin/zplugin.lock"
ZPLUGIN_SAVE_DIR="${XDG_DATA_HOME}/zplugin"
ZPLUGIN_DEFAULT_PLUGINS=(
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-completions
) # Defaults are considered only if lockfile is not present

# TODO: add --dry-run
_zplugin_usage() {
    cat <<'EOF'
ZPLUGIN
A minimal zsh plugin manager.

usage: zplugin [-v|--verbose -d|--dry-run -l|--log-disabled] [--] <command> [args] 

commands:
    install <plugin> [-c|--commit <sha>] clone a plugin and at it to lockfile
    update  <plugin> [-c|--commit <sha>] update one plugin, or all if plugin name omitted
    remove  <plugin> [-y|--yes]          delete a plugin and drop it from the lockfile
    list             [-b|--bat]          list installed plugins
    help                                 show this message

options:
    -i, --info-disabled                  completely disable returned stdout info 
    -d, --dry-run                        show what would happen without making changes 

<plugin> is in <owner/repo> format, e.g. zsh-users/zsh-autosuggestions 
EOF
}

zplugin() {
    local ZPLUGIN_DRY_RUN ZPLUGIN_INFO_DISABLED _operation _status
    while [[ "$1" == -* ]]; do
        case "$1" in
        --help | -h)
            _zplugin_usage
            return 0
            ;;
        --dry-run | -d)
            ZPLUGIN_DRY_RUN=true
            shift
            ;;
        --info-disabled | -i)
            ZPLUGIN_INFO_DISABLED=true
            shift
            ;;
        --)
            shift
            break
            ;;
        -*)
            _zplugin_info "Unknown global flag: $1" >&2
            _zplugin_usage >&2
            return 1
            ;;
        esac
    done

    if [[ -n "$1" ]]; then
        _operation="$1"
        shift
    else
        _zplugin_info "Command not provided" >&2
        return 1
    fi

    case "$_operation" in
    install)
        _zplugin_install "$@" && _zplugin_sync
        _status="$?"
        ;;
    update)
        _zplugin_update "$@" && _zplugin_sync
        _status="$?"
        ;;
    remove)
        _zplugin_remove "$@" && _zplugin_sync
        _status="$?"
        ;;
    list)
        _zplugin_list "$@"
        _status="$?"
        ;;
    *)
        _zplugin_info "$_operation is invalid command" >&2
        _zplugin_usage >&2
        return 1
        ;;
    esac
    return "$_status"
}

_zplugin_info() {
    local _message="$1"
    [[ "$ZPLUGIN_INFO_DISABLED" == true ]] || echo "$_message"
}

_zplugin_install() {
    local _plugin _dir _commit _old_head
    local _opts=(--depth=1)

    _plugin="$1"
    _zplugin_validate_name "$_plugin" || return 1
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
    if [[ -d "$_dir" ]]; then
        _old_head="$(git -C "$_dir" rev-parse HEAD)"
        if [[ -n "$_commit" && "$_old_head" != "$_commit" ]]; then
            _zplugin_update_single "$_plugin" --commit "$_commit" || return 1
            _zplugin_info "$_plugin: switching from $_old_head to requested $_commit"
        else
            _zplugin_info "$_plugin already installed, nothing to do"
        fi
        return 0
    fi

    [[ -n "$_commit" ]] && _opts+=(--revision "$_commit")
    [[ -z "$ZPLUGIN_VERBOSE" ]] && _opts+=(--quiet)

    local _out
    if _out="$(git clone "${_opts[@]}" "https://github.com/$_plugin" "$_dir" 2>&1)"; then
        _zplugin_info "Installed $_plugin"
        return 0
    else
        _zplugin_info "Failed to clone $_plugin: $_out"
        return 1
    fi
}

_zplugin_update() {
    local _plugin="$1"
    if [[ -n "$_plugin" ]]; then
        _zplugin_update_single "$@" || return 1
    else
        _zplugin_update_all || return 1
    fi
}

_zplugin_update_single() {
    local _plugin _dir _commit _old_head _new_head

    _plugin="$1"
    _zplugin_validate_name "$_plugin" || return 1
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
            _zplugin_info "Unknown flag: $1" >&2
            _zplugin_usage >&2
            return 1
            ;;
        esac
    done

    _dir="$ZPLUGIN_SAVE_DIR/$_plugin"
    _old_head="$(git -C "$_dir" rev-parse HEAD)"

    git_failure() {
        local _plugin _out _commit
        _plugin="$1"
        _out="$2"
        _commit="$3"
        if [[ -n "$_resolved" ]]; then
            _zplugin_info "Failed to update $_plugin to $_resolved: $_out" >&2
        else
            _zplugin_info "Failed to update $_plugin: $_out" >&2
        fi
    }

    local _out
    if [[ -n "$_commit" ]]; then
        if ! _out="$(git -C "$_dir" fetch --depth=1 origin "$_commit" 2>&1)"; then
            git_failure "$_plugin" "$_out" "$_commit"
            return 1
        fi
        if ! _out="$(git -C "$_dir" checkout --detach "$_commit" 2>&1)"; then
            git_failure "$_plugin" "$_out" "$_commit"
            return 1
        fi
    else
        if ! _out="$(git -C "$_dir" fetch --depth=1 origin 2>&1)"; then
            git_failure "$_plugin" "$_out"
            return 1
        fi
        if ! _out="$(git -C "$_dir" reset --hard FETCH_HEAD 2>&1)"; then
            git_failure "$_plugin" "$_out"
            return 1
        fi
    fi

    _new_head="$(git -C "$_dir" rev-parse HEAD)"
    if [[ "$_old_head" != "$_new_head" ]]; then
        _zplugin_info "Updated $_plugin: $_old_head → $_new_head"
    else
        _zplugin_info "$_plugin already up to date"
    fi
}

_zplugin_update_all() {
    local _plugin
    while read -r _plugin _; do
        _zplugin_update_single "$_plugin"
    done <"$ZPLUGIN_LOCKFILE"
}

_zplugin_remove() {
    local _plugin _dir _yes _reply

    _plugin="$1"
    _zplugin_validate_name "$_plugin" || return 1
    shift

    while [[ $# -ne 0 ]]; do
        case "$1" in
        --yes | -y)
            _yes=true
            shift 1
            ;;
        *)
            _zplugin_info "Unknown flag: $1" >&2
            _zplugin_usage >&2
            return 1
            ;;
        esac
    done

    _dir="$ZPLUGIN_SAVE_DIR/$_plugin"
    if [[ ! -d "$_dir" ]]; then
        _zplugin_info "$_plugin not installed"
        return 1
    fi

    if [[ "$_yes" != true ]]; then
        read -r "?Are you sure you want to remove plugin $_plugin? (y/N) " _reply
        [[ "$_reply" =~ ^([Yy]|[Yy][Ee][Ss])$ ]] || return 0
    fi

    rm -rf "$(dirname "$_dir")"
    _zplugin_info "Removed $_plugin"
}

_zplugin_list() {
    local _command _bat
    _command="cat"

    while [[ $# -ne 0 ]]; do
        case "$1" in
        --bat | -b)
            _bat=true
            shift 1
            ;;
        *)
            _zplugin_info "Unknown flag: $1" >&2
            _zplugin_usage >&2
            return 1
            ;;
        esac
    done

    if [[ "$_bat" == true ]]; then
        if command -v bat >/dev/null 2>&1; then
            _command="bat"
        else
            _zplugin_info "'bat' is not installed, fallback to 'cat'"
            _command="cat"
        fi
    fi
    "$_command" "$ZPLUGIN_LOCKFILE"
}

_zplugin_validate_name() {
    local _plugin="$1"
    if [[ ! "$1" =~ ^([^/]+)/([^/]+)$ ]]; then
        echo "Plugin name ($_plugin) is not in format <owner>/<repo>" >&2
        _zplugin_usage >&2
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
        zplugin --info-disabled install "$_plugin" --commit "$_commit" || return 1
    done <"$ZPLUGIN_LOCKFILE"
}

_zplugin_restore_default() {
    local _plugin
    for _plugin in "${ZPLUGIN_DEFAULT_PLUGINS[@]}"; do
        zplugin --info-disabled install "$_plugin" || return 1
    done
}

_zplugin_init() {
    [[ -d "$ZPLUGIN_SAVE_DIR" ]] || mkdir -p "$ZPLUGIN_SAVE_DIR"

    if [[ -f "$ZPLUGIN_LOCKFILE" ]]; then
        _zplugin_restore_lockfile
    else
        _zplugin_restore_default && _zplugin_sync
    fi

    _zplugin_source_lockfile
}

_zplugin_init
