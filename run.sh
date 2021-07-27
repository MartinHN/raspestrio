#!/usr/bin/env bash

cd server
npm run run &
cd ..

cd omxServer
./autoStart.sh &
cd ..
