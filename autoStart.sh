cd server
if [ -f /boot/isServer ]; then
	echo "starting as main server"
	./autoStartServer.sh
else
	echo "starting client"
	./autoStart.sh
fi
