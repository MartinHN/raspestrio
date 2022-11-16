git pull --recurse-submodules
#set -e -x
if [ $(uname -m) == "armv7l" ]; then
	isPi=1
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

for folder in server; do
	cd server
	H=$(git rev-parse HEAD)
	if [ "$H" != "$(getCommitBuilt)" ]; then
		echo "rebuilding $folder"
		./build.sh
		if [ $? == 0 ]; then
			echo $H >builtCommit
			echo "build completed for $folder"
		else
			echo "build failed for $folder"
		fi
	else
		echo "$folder up to date"
	fi
	cd ..
done

setRW ro

if [ $isPi ]; then
	sudo systemctl restart lumestrio
	sudo systemctl restart omxserver
fi
