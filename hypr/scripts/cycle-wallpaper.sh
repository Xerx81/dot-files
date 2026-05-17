#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures/Wallpapers/gruvbox"
STATE_FILE="/tmp/hypr_wallpaper_index"

# Get all wallpapers
mapfile -t wallpapers < <(find "$WALL_DIR" -type f \( \
    -iname "*.jpg" -o \
    -iname "*.jpeg" -o \
    -iname "*.png" \) | sort)

count=${#wallpapers[@]}

# Exit if no wallpapers found
[ "$count" -eq 0 ] && exit 1

# Read current index
if [ -f "$STATE_FILE" ]; then
    index=$(cat "$STATE_FILE")
else
    index=0
fi

# Next wallpaper
index=$(( (index + 1) % count ))

# Save new index
echo "$index" > "$STATE_FILE"

# Kill previous swaybg instance
pkill swaybg

# Start new wallpaper
swaybg -i "${wallpapers[$index]}" -m fill &
