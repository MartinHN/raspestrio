#!/usr/bin/env bash
###
# this script is not yet tested
PIADDR=$1
LOCALD=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
echo $LOCALD

scp -r view-dist ${PIADDR}:/home/pi/raspestrio/
scp -r server/out ${PIADDR}:/home/pi/raspestrio/server/out

ssh $PIADDR LOCALD=$LOCALD 'bash -s' <<'ENDSSH'
sudo mount -o remount,rw /;
cd raspestrio
scp -r tinmarbook@tinmarbook.local:$LOCALD/view-dist .
scp -r tinmarbook@tinmarbook.local:$LOCALD/server/out server/
sudo mount -o remount,ro /;
sudo systemctl restart lumestrio

ENDSSH
