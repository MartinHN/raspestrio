##########
# ReadOnly precautions (this seems to ssh keep connection active):
#    remount as rw
#    sudo systemctl restart NetworkManager
#    sudo nmtui

#inspired from https://gist.github.com/narate/d3f001c97e1c981a59f94cd76f041140
export ConName=ohmsweet
export APSSID=ohmsweetohmPi
export APPWD=sucemonbeat
export IFNAME=wlan0

#start DHCPCD server

sc restart NetworkManager

# sometimes ifup / down can work with "sudo ip link set wlan0 down"
# following may need sudo
NMCLI=nmcli
# option 1
nmcli dev wifi hotspot ifname $IFNAME ssid $ohmsweetohmPi password "$APPWD"

nmcli dev wifi hotspot ifname wlx40ed002a90e4 ssid ohmsweetohmPi password "sucemonbeat"

exit 1
#configuration
nmcli con add type wifi ifname $IFNAME con-name $ConName autoconnect yes ssid $APSSID
nmcli con modify $ConName 802-11-wireless.mode ap 802-11-wireless.band bg ipv4.method shared
nmcli con modify $ConName wifi-sec.key-mgmt wpa-psk
nmcli con modify $ConName wifi-sec.psk "$APPWD"

#apply it
nmcli con up $ConName
# Note if previous line don't work on reboot
# UUID=$(grep uuid /etc/NetworkManager/system-connections/Hotspot | cut -d= -f2)
# nmcli con up uuid $UUID
