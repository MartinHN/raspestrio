cd schedule
npm run build

cd ../server
npm run package

cd ../androidjs
androidjs b
adb install ./dist/lumestrio.apk
