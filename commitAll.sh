function commitAll(){
git add -A
set +e  # Grep succeeds with nonzero exit codes to show results.
git status | grep committed
if [ $? -eq 0 ]
then
    set -e
    git status
    read -r -p "Commit $1? [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            git commit -m "WIP $(date)"
            git push
            ;;
        *)
            echo "aborting"
            ;;
    esac
else
    set -e
    echo "No changes since last run"
fi
}

cd server
commitAll

cd ../rpi-rtc
commitAll

cd ../Vermuth
commitAll

cd ../schedule
commitAll

cd ../omxServer
commitAll

cd ..
commitAll
