#!/usr/bin/env bash
### this sends lumestrio files to given pi@lumestrio1X

syncPi() {
    PIADDR=$1
    LOCALD=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
    echo syncing $PIADDR on $LOCALD

    ssh $PIADDR LOCALD=$LOCALD 'bash -s' <<'ENDSSH'
sudo mount -o remount,rw /;
cd raspestrio
rsync -r -e ssh -avz --delete-after tinmarbook@tinmarbook.local:$LOCALD/view-dist/ view-dist/
rsync -r -e ssh -avz --delete-after tinmarbook@tinmarbook.local:$LOCALD/server/out/ server/out/
sudo mount -o remount,ro /;
sudo systemctl restart lumestrio

ENDSSH
}

for var in "$@"; do
    ADDR="pi@lumestrio$var.local"
    syncPi $ADDR
done
