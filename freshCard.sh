# cmd="
# "

if [ "$1" == "" ]; then
    "echo must provide name"
    exit 1
fi

# waitOnline lumestrio1.local

ssh pi@lumestrio1.local NEWNAME=$1 'bash -s' <<'ENDSSH'
echo "$NEWNAME"
uname -a
if [ -f /etc/fstab.rw.bk ]; then
echo "re applyibng fresh???"
else
sudo cp /etc/fstab /etc/fstab.rw.bk
fi
sudo sh raspestrio/server/src/changeHostName.sh $NEWNAME
sudo cp /etc/fstab /etc/fstab.rw.bk
sudo cp /etc/fstab.ro.bk /etc/fstab
sudo reboot
ENDSSH
