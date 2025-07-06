#!/bin/bash

pid=$(hyprctl activewindow | grep -o 'pid: .*' | sed 's|pid: \(.*\)|\1|')
ppid=$(pgrep --newest --parent $pid)
dir=$(readlink /proc/$ppid/cwd)

kitty -d $dir
