# D-bus
if which dbus-launch >/dev/null 2>&1 && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

# Preload stuff for KDE apps
if which kdeinit4 >/dev/null 2>&1; then
  LD_BIND_NOW=true kdeinit4 --no-fork --no-kded --suicide && kcminit &
fi
export QT_PLUGIN_PATH=$HOME/.kde4/lib/kde4/plugins/:/usr/lib/kde4/plugins/

#Auto inicio
sleep 1s && numlockx on &
sleep 1s && setxkbmap es &
sleep 2s && setxkbmap -option terminate:ctrl_alt_bksp &
sleep 19s && wicd-kde &
sleep 9s && xscreensaver -no-splash &
sleep 8s && razor-runner &
sleep 8s && kupfer --no-splash &
sleep 6s && clipit &
#sleep 5s &&  trayer --align right --edge bottom --expand false --width 18 &
sleep 6s && xrdb -merge ~/.Xresources &
#sleep 5s && urxvtd -f & 
#sleep 3s && conky -c .conkyplacid &
#sleep 3s && tint2 -c .config/tint2/tinthotd &
sleep 3s && bmpanel2 --theme=/usr/share/bmpanel2/themes/Kupo-dark-red/ &
#sleep 4s && razor-desktop &
#sleep 3s && razor-panel &
sleep 7s && xcompmgr -f -F -r 3.95 -o 0.42 -l 3.7 -t 6.6 -I 0.022 -O 0.02 -D 7 -m.88 &
#sleep 2s && cairo-compmgr &
#nitrogen --restore &
hsetroot -fill Dropbox/Photos/Wallpapers/Blood/HIGHSCHOOL_OF_THE_DEAD_Chibi_Wallpaper__yvt2.jpg &
xhost + 
