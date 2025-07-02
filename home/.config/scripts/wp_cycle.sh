#!/bin/bash

# clear
if [ "$1" = '--clear' ]; then
    echo "Clearing"
    rm -r ~/.config/wal/colorschemes/*
fi

# pregen
mapfile -t imgs < <(find ~/Downloads/wps/night -type f)

for img in "${imgs[@]}"; do
    filename=$(basename "$img")
    theme=$(find ~/.config/wal/colorschemes | grep "$filename")

    if [ "$theme" != '' ]; then
        echo "Skipping" $img
    else
        echo "Generating" $img
        wal --cols16 -i "$img" -ntesq --contrast 2.0 -p "$filename"
    fi
done

#set
# for img in "${imgs[@]}"; do
while true; do
    img=$(find ~/Downloads/wps/night -type f | shuf -n 1)

    # echo "Setting" $img

    swww img "$img" \
        --transition-type fade \
        --transition-step 60 \
        --transition-fps 60

    filename=$(basename "$img")
    wal -qf "$filename"

    sleep 60
done
