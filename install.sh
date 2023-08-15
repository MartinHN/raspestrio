#!/usr/bin/env bash
set -e
pushd .
cd schedule
pnpm i
popd
pushd .
cd server
pnpm i
popd
cd omxServer
pnpm i
