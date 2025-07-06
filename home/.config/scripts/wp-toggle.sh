#!/bin/bash

pid=$(pgrep wp-cycle.sh)


if [ "$pid" = '' ]; then
    echo "Run wp-cycle.sh"
    swww-daemon & ~/.config/scripts/wp-cycle.sh &
else
    echo "Kill $pid"
    swww kill & kill -9 $pid
fi
