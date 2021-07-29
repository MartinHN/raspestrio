#!/usr/bin/env bash

PIADDR=$1

scp -r view-dist ${PIADDR}:/home/pi/raspestrio/
scp -r server/out ${PIADDR}:/home/pi/raspestrio/server/out
