# D-bus
if which dbus-launch >/dev/null 2>&1 && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi


#Auto inicio
sleep 1s && numlockx on &
sleep 1s && setxkbmap es &
sleep 2s && setxkbmap -option terminate:ctrl_alt_bksp &
sleep 19s && wicd-kde &
sleep 9s && xscreensaver -no-splash &
sleep 8s && razor-runner &
sleep 5s && kupfer --no-splash &
sleep 6s && qlipper &
#sleep 5s &&  trayer --align right --edge bottom --expand false --width 18 &
sleep 6s && xrdb -merge ~/.Xresources &
#sleep 3s && conky -c .conkyplacid &
sleep 3s && avant-window-navigator &
xcompmgr -f -F -r 3.95 -o 0.42 -l 3.7 -t 6.6 -I 0.022 -O 0.02 -D 7 -m.88 &
#sleep 2s && cairo-compmgr &
#nitrogen --restore &
hsetroot -fill Dropbox/Photos/Wallpapers/ALIVE_Pearl_Jam_Wallpaper_by_BaronOfEvil.jpg &
if [[ $(uname -r) == '3.0-ck' ]]
then
    mpd ~/.mpd/mpdpulse.conf &
else
    mpd ~/.mpd/mpd.conf &
fi
xhost + 
