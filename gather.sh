#! /bin/bash

# vars

scriptDir=$(dirname "$0")

items=(
    ~/.config/nvim
    ~/.config/ags

    ~/.bashrc
    ~/.config/hypr/hyprland.conf
    ~/.config/kitty/kitty.conf
    /etc/sddm.conf.d/default.conf
    /usr/share/sddm/scripts/Xsetup
    /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
    /usr/share/sddm/themes/sddm-astronaut-theme/Themes/hyprland_kath.conf
)

# copy

for item in ${items[@]}; do
    localItem=$(echo "$item" | sed "s|^$HOME|/home|")
    localItemDir=$(dirname $localItem)

    echo "Copying $item"

    mkdir -p $scriptDir$localItemDir
    cp -r $item $scriptDir$localItemDir
done
