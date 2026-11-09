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

wallust run "$MODEL" --palette light16 --backend wal

awww img "$MODEL"\
  --transition-type grow \
  --transition-pos top-left \
  --transition-step 90 \
  --transition-fps 60

hyprctl dispatch 'hl.dsp.exec_cmd("waybar")'
