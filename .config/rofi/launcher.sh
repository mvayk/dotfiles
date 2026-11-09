#!/usr/bin/env bash
rofi \
  -show drun \
  -display-drun "run:" \
  -drun-display-format "{name}" \
  -theme ~/.config/rofi/theme.rasi \
  -kb-accept-entry "Return" \
  -no-fixed-num-lines \
  -hide-scrollbar
