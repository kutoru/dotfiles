#! /bin/bash

# vars

scriptDir=$(dirname "$0")

dirs=(
    ~/.config/nvim
    ~/.config/ags
)

files=(
    ~/.bashrc
    ~/.config/hypr/hyprland.conf
    ~/.config/kitty/kitty.conf
)

# copy

for item in ${dirs[@]} ${files[@]}
do
    localItem=$(echo "$item" | sed "s|^$HOME|/home|")
    localItemDir=$(dirname $localItem)

    echo "Copying $item"

    mkdir -p $scriptDir$localItemDir
    cp -r $item $scriptDir$localItemDir
done
