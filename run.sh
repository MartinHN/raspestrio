#!/usr/bin/env bash

cd server
pnpm run run &
cd ..

cd omxServer
./autoStart.sh &
cd ..
