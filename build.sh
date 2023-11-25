#!/usr/bin/env bash
set -e

cd schedule
pnpm run build
cd ..
cd server
pnpm run build
cd ..

# cd Vermuth
# ./build.sh
# cd ..
