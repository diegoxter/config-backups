driver="$1"

if [[ "$(id -u)" != "0" ]]
then 
    echo "This script must be run as root" 1>&2
elif [[ "$(id -u)" == "0" ]]
then

glselect $1 &> /dev/null
if [[ $driver == "show" ]]
then
    for e in '/home/diegoxter/terror.txt' 
    do
	echo "LibGL driver is $( glselect show )"
	ls -l /etc/X11/xorg.conf | cut -d- -f2
	cat /etc/rc.conf | grep nvidia | cut -b 259-265
	cat /etc/rc.conf | grep nouveau | cut -b 259-265
    done
elif [[ $driver == "nvidia" ]]
then
    echo "LibGL is now set to $( glselect show )" 
    sed -i -e 's/nouveau/nvidia/g' /etc/rc.conf
    sed -i -e 's/blacklist nvidia/blacklist nouveau/g' /etc/modprobe.d/nouveau_blacklist.conf
    sed -i -e 's/#vga=795/vga=795/g' /boot/grub/menu.lst
    unlink /etc/X11/xorg.conf
    ln -s /home/diegoxter/backups/xorg.conf.nvidia /etc/X11/xorg.conf
elif [[ $driver == "mesa" ]]
then
    echo "LibGL is now set to $( glselect show )"
    sed -i -e 's/nvidia/nouveau/g' /etc/rc.conf
    sed -i -e 's/blacklist nouveau/blacklist nvidia/g' /etc/modprobe.d/nouveau_blacklist.conf
    sed -i -e 's/vga=795/#vga=795/g' /boot/grub/menu.lst
    unlink /etc/X11/xorg.conf
    ln -s /home/diegoxter/backups/xorg.conf.nouveau /etc/X11/xorg.conf
fi
fi
exit
