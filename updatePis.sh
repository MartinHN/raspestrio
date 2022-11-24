#!/usr/bin/env bash
serverAddr=http://lumestrio1.local:3003/knownDevices

function getAllKnown() {
    echo $(curl $serverAddr --silent | jq -r " to_entries[] |  select(.key | startswith(\"lumestrio@\") )  | .value")
}

function showKd() {
    echo $(jq -r " {ip, deviceName} " <<<$1)
}
function getAllIpRegistered() {
    echo $(jq -r .ip <<<$1)
}

function getNiceNameFromIp() {
    ip=$(sed -e 's/"//g' <<<"$2")
    echo $(jq -r " select(.ip==\"$ip\") | {ip, deviceName, niceName}" <<<$1)
}

function printNicenames() {
    for a in $2; do
        echo $(getNiceNameFromIp "$1" "$a")
    done
}

kd="$(getAllKnown)"
# echo "$(showKd "$kd")"
ips=$(getAllIpRegistered "$kd")
# echo "$(getNiceNameFromIp "$kd" 192.168.43.74)"
echo "$(printNicenames "$kd" "$ips")"

function updatePi() {

    ssh pi@$1 NEWNAME=$1 'bash -s' <<'ENDSSH'
# source /home/pi/.bash_profile
# whoami
nvm use 16
sudo systemctl stop lumestrio
sudo mount -o remount,rw /;
cd raspestrio
cd omxServer
git checkout .
cd ..
cd server
git checkout .
cd ..
cd schedule
git checkout .
cd ..
git pull local
./rpiUpdate.sh
sudo mount -o remount,ro /;

ENDSSH

}

for i in $ips; do
    echo "updating ${i} . $(getNiceNameFromIp $i)"
    updatePi $i
done
