hsetroot -fill /home/diegoxter/Imágenes/walls/psychod/1359584045721.jpg
tint2 -c /home/diegoxter/.config/tint2/popout.tint2rc &
sleep 1s && urxvt +sb -tr -fg blue -g 169x19+0+0 -si -e \
/bin/sh ~/Público/backups/openbox/scripts/urxvtmux.sh &
sleep 1s && compton --config ~/.config/compton.conf &
sleep 2s && urxvt +sb -tr -g 80x24+0+0\ -si -sw -e htop &
sleep 3s && urxvt +sb -tr -sh 150 -g 48x24+0+0 -si -sw -e ncmpcpp &
sleep 4s && dbus-launch volti &
