#! /bin/bash

# install yay

yay --version

if [ $? -eq 127 ]; then
    echo ""
    echo "===== Installing yay ====="
    echo ""

    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

# install everything else

echo ""
echo "===== Installing packages ====="
echo ""

# sddm themes: https://github.com/Keyitdev/sddm-astronaut-theme
# sddm itself:
yay -S --needed sddm qt6-svg qt6-multimedia-ffmpeg xorg-xrandr

# also install:
#something ags something something astal
#mpv mpv-mpris or vlc
# misc:
yay -S --needed pactl fzf nvim hypridle
