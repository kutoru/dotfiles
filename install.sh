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

yay -S --needed vlc
