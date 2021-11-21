git pull --recurse-submodules

cd server
npm run build


sudo systemctl restart lumestrio
sudo systemctl restart omxserver

