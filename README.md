# raspestrio
root repo for experiments on light/sound/radio mini machines
using Raspberries

*Warning everything is pretty much WIP*


most of dev environment uses vscode... 
to start :
```
git clone --recurse-submodules https://github.com/MartinHN/raspestrio.git

code raspestrio
```

## port mapping
- pi are accessible at ip :  lumestrioX.local. (i.e lumestrio1.local)
- global server web accessible at http://WhateverMasterNameIs:3003
- audio configuration : http://piIpAddress:8000.  (OSC communication uses 9009)

# Repos 
## server
Main entry point, backend for triggering of audio (omxServer) / light (vermuth) / relay (rpi gpio) / and lora communications.

one instance must be "master" see autoStart.sh.

Notes on "master" :
- he is the one responsible of transmitting Lora, using the biggest antenna
- all rpis are the same, the master just need to have an existing file at "/boot/isServer" to be considered as the master (see autoStart.sh)
- it allows to list all connected raspberries and esp32s



## schedule
this is the frontend for managing global stuff:
-  agendas editing
- see connected device
- test them individually
- launch inauguration ...


## omxServer
Audio backend, can play files, store volume...  (Wav files only...)

## piLora
python script to proxy websocket to lora.

## rpi-rtc
used to setup rtcs on raspberries


## androidjs (not used)
WIP to have a dedicated offline android app to manage raspberries/agendas offline

### notes
lots of script are helping updating all raspberries or all esp32s, while on-site. but theyre even more WIP.  


## esp32 relays
see https://github.com/MartinHN/relaystrio
