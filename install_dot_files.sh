#!/usr/bin/env bash

[ -z "$XDG_CONFIG_HOME" ] && echo "XDG_CONFIG_HOME not set!" && exit 1

for dots in */ ; do
  echo "linking to $dots from $XDG_CONFIG_HOME/$(basename $dots)"
  ln -sTrf "$dots" "$XDG_CONFIG_HOME"/"$(basename $dots)" || exit 1
done

