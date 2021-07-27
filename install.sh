#!/usr/bin/env bash
set -e
pushd .
cd schedule
npm i
popd
pushd .
cd server
npm i
popd
cd omxServer
npm i
