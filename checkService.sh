#!/bin/bash

function printService() {
    echo "--------------"
    echo "$1"
    systemctl status --no-pager $1 | grep 'Active'
    systemctl is-active --quiet $1
    isActive=$?
    if [[ "$isActive" != "0" ]]; then
        journalctl -u $1 -n30 --no-pager
    fi
}

printService lumestrio.service

printService vermuth.service
printService omxserver.service

printService lora.service

printService e32.service
