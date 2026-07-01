#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <wallpaper_path>"
  exit 1
fi

MODEL="$1"

if [ ! -f "$MODEL" ]; then
  echo "Error: file not found: $MODEL"
  exit 1
fi

pkill waybar

wallust run --palette softlight16 --colorspace lchmixed "$MODEL"
awww img "$MODEL"

hyprctl dispatch 'hl.dsp.exec_cmd("waybar")'

pkill ghostty
