#!/bin/bash

mapfile -t input < <(pactl get-sink-volume @DEFAULT_SINK@ | sed 's/,/\n/')

volume_left=$(echo ${input[0]} | sed 's|.*/ \([0-9]\{1,3\}\)% /.*|\1|' | sed 's/%//')
volume_right=$(echo ${input[1]} | sed 's|.*/ \([0-9]\{1,3\}\)% /.*|\1|' | sed 's/%//')
balance=$(echo ${input[2]} | sed 's/balance //')

echo $volume_left $volume_right $balance
