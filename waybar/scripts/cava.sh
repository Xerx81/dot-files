#!/bin/bash

# 1. Nuke existing processes
killall cava 2>/dev/null

bar="▁▂▃▄▅▆▇█"
dict=""

# Calculate the length of the bar outside the loop
bar_length=${#bar}

# Create array mapping numbers to bars for awk
for ((i = 0; i < bar_length; i++)); do
    dict+="$i:${bar:$i:1},"
done

mkdir -p ~/.config/cava
config_file="$HOME/.config/cava/waybar_cava_config"

cat >"$config_file" <<EOF
[general]
framerate = 60
bars = 14
set_terminal_title = 0

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

# 2. Run with stdbuf to completely destroy terminal caching
# We use an interactive awk command that flushes every line instantly
stdbuf -oL cava -p "$config_file" | awk -v dict_str="$dict" '
BEGIN {
    split(dict_str, pairs, ",");
    for (i in pairs) {
        if (split(pairs[i], kv, ":") == 2) {
            map[kv[1]] = kv[2]
        }
    }
}
{
    # Strip any potential escape sequences \x1b and \x07
    gsub(/\x1b\][^\x07]*\x07/, "");
    
    # Process string characters line by line
    line = ""
    len = length($0)
    for (i = 1; i <= len; i++) {
        ch = substr($0, i, 1)
        if (ch in map) {
            line = line map[ch]
        } else if (ch != ";") {
            line = line ch
        }
    }
    print line
    fflush() # Forces the text to shoot directly into the terminal/Waybar
}'
