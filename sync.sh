#!/usr/bin/env bash
# copies my configs from where they're from into this repo

# ./sync.sh "message"   copy+commit+push
set -euo pipefail

repo="$(cd "$(dirname "$0")" && pwd)"
cd "$repo"

# where it lives, where it goes in backup
# trailing / replaces folder contents
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

git add -A
git status --short

if [ $# -eq 0 ]; then
    exit 0
fi

git commit -m "$1"
git push
