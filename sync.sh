#!/usr/bin/env bash

set -euo pipefail

repo="$(cd "$(dirname "$0")" && pwd)"
cd "$repo"

# trailing / replaces all things in folder
files=(
    "$HOME/.config/hypr/hyprland.lua"                          "hyprland.lua"
    "$HOME/.config/hypr/hypridle.conf"                         "hypridle.conf"
    "$HOME/.config/hypr/hyprlock.conf"                         "hyprlock.conf"
    "$HOME/.config/hypr/hyprsunset.conf"                       "hyprsunset.conf"
    "$HOME/.config/hypr/pyprland.toml"                         "pyprland.toml"
    "$HOME/.config/hypr/hyprlock/"                             "hyprlock/"
    "$HOME/.config/wlogout/"                                   "wlogout/"
    "$HOME/.config/waybar/user-style.css"                      "waybar/user-style.css"
    "$HOME/.config/waybar/layouts/"                            "waybar/layouts/"
    "$HOME/.config/waybar/includes/"                           "waybar/includes/"
    "$HOME/.config/kitty/kitty.conf"                           "kitty/kitty.conf"
    "$HOME/.local/bin/custom-colors"                           "custom-colors"
    "$HOME/.config/hyde/wallbash/always/custom-colors.dcol"    "custom-colors.dcol"
)

for ((i = 0; i < ${#files[@]}; i += 2)); do
    src="${files[i]}"
    dest="${files[i + 1]}"
    mkdir -p "$(dirname "$dest")"
    rsync -a --delete "$src" "$dest"
done
