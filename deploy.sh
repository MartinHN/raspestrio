#!/usr/bin/env bash
### this sends lumestrio files to given pi@lumestrio1X
if [[ "$1" == "" ]]; then
    tryAll="1"
fi

GITPULL=""
VERMUTH=""
RESTARTLUM="1"
syncPi() {
    PIADDR=$1
    LOCALD=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
    echo syncing $PIADDR on $LOCALD

    ssh $PIADDR LOCALD=$LOCALD GITPULL=$GITPULL VERMUTH=$VERMUTH RESTARTLUM=$RESTARTLUM 'bash -s' <<'ENDSSH'
sudo mount -o remount,rw /;
cd raspestrio
if [[ $GITPULL ]]; then echo "updatingGIIIT"; git pull --recurse-submodules; git reset --hard --recurse-submodule; fi;
rsync -r -e ssh -avz --delete-after -i tinmarbook@tinmarbook.local:$LOCALD/view-dist/ view-dist/ 
rsync -r -e ssh -avz --delete-after -i tinmarbook@tinmarbook.local:$LOCALD/server/out/ server/out/ 
rsync -r -e ssh -avz --delete-after -i tinmarbook@tinmarbook.local:$LOCALD/Vermuth/server/dist/ Vermuth/server/dist/ 
rsync -r -e ssh -avz --delete-after -i tinmarbook@tinmarbook.local:$LOCALD/Vermuth/server/distPacked/ Vermuth/server/distPacked/ 
if [[ $VERMUTH ]]; then cd Vermuth/server ; /home/pi/.local/share/pnpm/pnpm i; cd ../.. ; fi ;
sudo mount -o remount,ro /;
if [[ $RESTARTLUM ]]; then sudo systemctl restart lumestrio; fi;
if [[ $VERMUTH ]]; then sudo systemctl restart vermuth; fi ;

ENDSSH
}

function getAllHostNamesOnNetwork() {
    dns-sd -B _rspstrio._udp >/tmp/lumstrios &
    sleep 1 && kill %1
    rhns=$(grep -o -E "lumestrio.*" /tmp/lumstrios)
    hns=""
    for hn in $rhns; do
        hns="$hns $hn.local"
    done
    echo $hns
}

if [[ $tryAll == "1" ]]; then
    hns=$(getAllHostNamesOnNetwork)
    if [[ "$hns" == "" ]]; then
        dbg "no hostnames found"
        exit 1
    fi
    echo $hns
    parallel --progress -j50 $0 ::: $hns
else

    for ADDR in "$@"; do
        len=${#ADDR}
        echo $len
        if [[ $len -lt 3 ]]; then
            ADDR="lumestrio$ADDR.local"
        fi
        syncPi pi@$ADDR
    done
fi

# git pull --recurse-submodules
# git reset --hard --recurse-submodule
# cd server
# /home/pi/.local/share/pnpm/pnpm i
