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

# --- HYPRPAPER TRANSITION ---
NEXT_WALL="${wallpapers[$index]}"

# 1. Preload the next image into memory
hyprctl hyprpaper preload "$NEXT_WALL"

# 2. Set it on all monitors (empty string before the comma target all monitors)
hyprctl hyprpaper wallpaper ",$NEXT_WALL"

# 3. Free up RAM by unloading any wallpapers not currently active
hyprctl hyprpaper unload unused
