#done plataneA 192.168.1.13  platB 192.168.1.8  platC 192.168.1.11 L26 1.25

# git remote add momo olivierclausse@192.168.1.35:/Users/olivierclausse/Documents/GitHub/omxServer/.git;
# git fetch momo;
# git switch -c MomoMaster momo/master;

ips="lumestrio2"
# echo "$(getNiceNameFromIp "$kd" 192.168.43.74)"
# echo "$(printNicenames "$kd" "$ips")"

function updatePi() {

    ssh pi@$1 NEWNAME=$1 'bash -s' <<'ENDSSH'
# source /home/pi/.bash_profile
# whoami


sudo systemctl stop lumestrio;
sudo mount -o remount,rw /;
cd raspestrio;
cd server;
git pull 
cd ..;

sudo systemctl restart lumestrio;
sudo systemctl restart omxserver;
sudo mount -o remount,ro /;

ENDSSH

}

for i in $ips; do
    echo "updating ${i} ."
    updatePi $i.local
done

cd raspestrio/omxServer
