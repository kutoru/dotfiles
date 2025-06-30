pid=$(hyprctl activewindow | grep -o 'pid: .*' | sed 's|pid: \(.*\)|\1|')
ppid=$(pgrep --newest --parent "$pid")
dir=$(readlink /proc/"$ppid"/cwd)

nvimMatch=$(hyprctl activewindow | grep -o 'title: nvim')
if [ "$nvimMatch" != '' ]; then
    kitty --hold -d $dir nvim .
else
    kitty -d $dir
fi
