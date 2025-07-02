#!/bin/bash

running=$(ags list)

if [ $running != '' ]; then
    ags quit
else
    ags run --gtk 4
fi
