#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/wallpapers"

# Build Rofi menu entries: display name + full path for icon
choice=$(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | sort |
while read -r wallpaper; do
    # Use basename for display, full path for icon
    echo -en "$(basename "$wallpaper")\x00icon\x1f$wallpaper\n"
done |
rofi -dmenu -i -show-icons \
     -theme-str 'element-icon { size: 8em; }' \
     -theme ~/.config/rofi/wallpaper.rasi \
     -format 'i' # output the index of the selected line
)

# Exit if nothing selected
[[ -z "$choice" ]] && exit 0

# Map index back to full wallpaper path
mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | sort)
selected_wallpaper="${wallpapers[$choice]}"

killall waybar

# Generate color scheme with wal
wal -i "$selected_wallpaper" -q -t -b 000000

# Set wallpaper with swww
swww img "$selected_wallpaper" \
  --transition-bezier 0.5,1.19,.8,.4 \
  --transition-type wipe \
  --transition-duration 2 \
  --transition-fps 260 \

hyprctl dispatch exec waybar
