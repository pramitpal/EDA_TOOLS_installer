mkdir OPENLANE_DIR
cd OPENLANE_DIR

sudo apt-get update
#pre-requisite
echo "#######################################################"
echo "#-------------Installing Pre Requisites---------------#"
echo "#######################################################"

sudo apt-get install -y build-essential vim-gtk3 xterm clang bison flex \
	libreadline-dev gawk tcl-dev libffi-dev git \
	graphviz xdot pkg-config python3 libboost-system-dev \
	libboost-python-dev libboost-filesystem-dev zlib1g-dev \
	make m4 tcsh csh libx11-dev gperf  tcl8.6-dev tk8.6 tk8.6-dev \
	libxmp4 libxpm-dev  libxcb1 libcairo2 libcairo2-dev mesa-common-dev libglu1-mesa-dev  \
      	libncurses-dev libxrender-dev libx11-xcb-dev libxaw7-dev freeglut3-dev automake

echo "#######################################################"
echo "#----------------Installing Docker--------------------#"
echo "#######################################################"
sudo apt install -y curl
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker 
rm -rf get-docker.sh


cd ~/OPENLANE_DIR/

