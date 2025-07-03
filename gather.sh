#! /bin/bash

# vars

scriptDir=$(dirname "$0")

items=(
    ~/.config/nvim
    ~/.config/hypr
    ~/.config/scripts
    ~/.config/ags

    ~/.bashrc
    ~/.config/kitty/kitty.conf
    ~/.config/gtk-4.0/settings.ini
    ~/.config/wofi/style.css
    /etc/sddm.conf.d/default.conf
    /usr/share/sddm/scripts/Xsetup
    /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
    /usr/share/sddm/themes/sddm-astronaut-theme/Themes/hyprland_kath.conf
)

# helpers

replace_home() {
    echo "$1" | sed "s|^$HOME|/home|"
}

get_root() {
    next=$(dirname $1)

    if [ $next = "/" ]; then
        echo $1
    else
        echo $(get_root $next)
    fi
}

# remove repo dirs

declare -A rootDirs

for item in ${items[@]}; do
    localItem=$(replace_home $item)
    rootDir=$(get_root $localItem)

    rootDirs[$rootDir]=1
done

for dir in "${!rootDirs[@]}"; do
    echo "Removing .$dir"

    rm -r $scriptDir$dir
done

# copy from host to repo

for item in ${items[@]}; do
    localItem=$(replace_home $item)
    localItemDir=$(dirname $localItem)

    echo "Copying into .$localItem"

    mkdir -p $scriptDir$localItemDir
    cp -r $item $scriptDir$localItemDir
done
