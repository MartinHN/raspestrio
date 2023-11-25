## note will be expanded on first boot
## it's faster to first copy the image on the host
####
# !!!!!!!! dont forget to remove /boot/isServer and /boot/hostname.txt
imgName=$1

hostImgDir=~/Work/momo/img
# imgPath=$hostImgDir/$imgName
# if [[ -f $imgPath ]]; then
#     smallImgName="$imgName.small"
#     smallImgPath=$hostImgDir/$smallImgName
#     echo will use $imgPath to generate $smallImgName
# else
#     echo path not found $imgPath
#     exit 1
# fi

# echo copying to $smallImgPath
# cp $imgPath $smallImgPath

smallImgPath=$hostImgDir/$imgName
smallImgName=$imgName
# exit 0
docker run -it -v ~/Work/momo/img/:/media/images --privileged=true pishmod /bin/bash -c "cd /media/images  && ls $smallImgName && pishrink -d -v /media/images/$smallImgName"

# to modify image, commit before closing
#docker ps
#docker commit <CONTAINER ID> pishmod
