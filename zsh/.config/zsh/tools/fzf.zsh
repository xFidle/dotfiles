#!/usr/bin/env zsh

local fzf_path="${XDG_CONFIG_HOME}/fzf"
local config="$fzf_path/config"
local theme="$fzf_path/themes/current"

export FZF_DEFAULT_OPTS="$(cat $config $theme)"
