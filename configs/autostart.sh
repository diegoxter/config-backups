#!/bin/sh
sleep 2s && setxkbmap -option terminate:ctrl_alt_bksp &
sleep 9s && wicd-kde &
sleep 9s && xscreensaver -no-splash &
sleep 5s && kupfer --no-splash &
sleep 6s && qlipper &
mpd ~/.mpd/mpd.conf &
xrdb -merge .Xresources
urxvtd &
xhost + 
