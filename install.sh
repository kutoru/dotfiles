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

# for music
#mpv mpv-mpris
# or
#vlc

#yay -S --needed {some packages}
