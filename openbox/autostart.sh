# This shell script is run before Openbox launches.
# Environment variables set here are passed to the Openbox session.

# D-bus
if which dbus-launch >/dev/null 2>&1 && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

# Run XDG autostart things.  By default don't run anything desktop-specific
# See xdg-autostart --help more info
#DESKTOP_ENV="GNOME"
#if which /usr/lib/openbox/xdg-autostart >/dev/null 2>&1; then
#  /usr/lib/openbox/xdg-autostart $DESKTOP_ENV
#fi

#Auto inicio
sleep 19s && wicd-client &
sleep 9s && xscreensaver -no-splash &
sleep 8s && kupfer --no-splash &
#sleep 8s && easystroke &
#sleep 7s && bmpanel2 --theme=auriel-green-opaque &
sleep 6s && clipit &
#sleep 5s &&  trayer --align right --edge bottom --expand false --width 18 &
sleep 6s && xrdb -merge ~/.Xresources &
sleep 5s && urxvtd -f & 
#sleep 4s && kiba-dock &
#sleep 3s && conky -c .conkyplacid &
#sleep 3s && tint2 -c .config/tint2/tinthotd &
sleep 3s && bmpanel2 &
sleep 2s && cairo-compmgr &
sleep 4s && thunar --daemon &
#nitrogen --restore &
hsetroot -fill Dropbox/Photos/Wallpapers/Blood/HIGHSCHOOL_OF_THE_DEAD_Chibi_Wallpaper__yvt2.jpg &
