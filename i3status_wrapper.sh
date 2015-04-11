#!/bin/bash

i3status -c ~/.i3/i3status.conf | while :
do
    read line
   # layout=$(xkb-switch)
    playing=$(mpc current)
    temp=$(sensors | grep "Physical" | grep -o '\+.*C ')

    let z=$(cat /sys/class/backlight/intel_backlight/brightness)
    let p=$(cat /sys/class/backlight/intel_backlight/max_brightness)
    brightness=$[z*100/p]
    echo " $playing |  $temp|  $brightness% | $line" || exit 1
done
