cd server
if [ -f /boot/isServer ]; then
	echo "starting as main server"
	npm run run -- -c --srv
else
	echo "starting client"
	npm run run -- -c
fi
