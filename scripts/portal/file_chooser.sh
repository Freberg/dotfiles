#!/usr/bin/env bash

multiple="$1"
directory="$2"
save="$3"
path="$4"
out="$5"

source "$HOME/.config/theme/env/current"

export NVIM_FILE_CHOOSER=1
export NVIM_FILE_CHOOSER_MULTI="$multiple"
export NVIM_FILE_CHOOSER_DIR="$directory"
export NVIM_FILE_CHOOSER_SAVE="$save"
export NVIM_FILE_CHOOSER_OUT_FILE="$out"

if [ -d "$path" ]; then
  target_path="$path"
else
  target_path=$(dirname "$path")
fi

kitten quick-access-terminal --instance-group="filechooser" nvim "$target_path"
