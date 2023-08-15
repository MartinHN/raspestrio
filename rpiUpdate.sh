#set -e -x
if [ "$1" == "sf" ]; then
	echo "will skip fetch"
	skipFetch=1
else
	skipFetch=0
fi

if [ "$1" == "sb" ]; then
	echo "will skip build"
	skipBuild=1
else
	skipBuild=0
fi

if [ $(uname -m) == "armv7l" ]; then

	isPi=1
	if [ $isPi ]; then
		echo "isPi"
	fi
fi

function setRW() {
	if [ $isPi ]; then
		sudo mount -o remount,$1 /
	else
		echo "ignore set RW $1"
	fi
}

function getCommitBuilt() {
	if [ -f builtCommit ]; then
		echo $(cat builtCommit)
		return
	fi
}

setRW rw
if [ "$skipFetch" == "0" ]; then
	if [ $isPi ]; then
		git reset --hard
		git submodule foreach --recursive git reset --hard
	fi
	git pull local --recurse-submodules=on-demand
fi

if [ "$skipBuild" == "1" ]; then
	exit 0
fi

toBuild="server Vermuth"
if [ -f /boot/isServer ]; then
	toBuild+=" schedule"
fi
for folder in $toBuild; do
	cd $folder
	H=$(git rev-parse HEAD)
	if [ "$H" != "$(getCommitBuilt)" ]; then
		echo "rebuilding $folder"
		if [ -f install.sh ]; then
			echo "installing $folder"
			./install.sh
		fi
		./build.sh
		if [ $? == 0 ]; then
			echo $H >builtCommit
			echo "build completed for $folder"
		else
			echo "build failed for $folder"
		fi
	else
		echo "$folder has already built $H"
	fi
	cd ..
done

setRW ro

if [ $isPi ]; then
	sudo systemctl restart lumestrio
	sudo systemctl restart omxserver
fi
