#!/usr/bin/env bash
set -e
pushd .
cd schedule
npm i
popd
cd server
npm i
