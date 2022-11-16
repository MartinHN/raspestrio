# git pull --recurse-submodules
#set -e -x

function setRW() {
	sudo mount -o remount,$1 /
}

function getCommitBuilt(){
if [ -f builtCommit ]; then 
	echo $(cat builtCommit)
	return
fi
}
setRW rw
for folder in server 
do
	cd server
	H=$(git rev-parse HEAD)
	if [ "$H" != "$(getCommitBuilt)" ]; then
		echo "rebuilding $folder"
		./build.sh
		if [ $? == 0 ]; then
			echo $H > builtCommit
			echo "build completed for $folder"
		else
			echo "build failed for $folder"
		fi
	else
		echo "$folder up to date"
	fi;
	cd ..
done;

setRW ro

sudo systemctl restart lumestrio
sudo systemctl restart omxserver

