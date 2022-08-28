mkdir EDA_TOOLS
cd EDA_TOOLS

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
echo "#----------------Installing magic VLSI----------------#"
echo "#######################################################"

git clone git://opencircuitdesign.com/magic
cd magic 
./configure
make 
sudo make install 
cd ..

#magic -T sky130A

echo "#######################################################"
echo "#----------------Installing Xschem--------------------#"
echo "#######################################################"

git clone https://github.com/StefanSchippers/xschem.git xschem
cd xschem
./configure 
make 
sudo make install 
mkdir ~/.xschem/
cd ~/.xschem/
mkdir xschem_library
cd xschem_library
git clone https://github.com/StefanSchippers/xschem_sky130.git xschem_sky130
cd xschem_sky130
cd ~/EDA_TOOLS/


echo "#######################################################"
echo "#-----------Installing openPDK and sky130nm-----------#"
echo "#######################################################"
#install sky130 pdk 
git clone https://github.com/google/skywater-pdk
cd skywater-pdk
git submodule init libraries/sky130_fd_io/latest
git submodule init libraries/sky130_fd_pr/latest
git submodule init libraries/sky130_fd_sc_hd/latest
git submodule init libraries/sky130_fd_sc_hvl/latest
git submodule update
make timing
cd ..

#install open_pdk , which help in installing sky130 tech file to our eda tool
git clone git://opencircuitdesign.com/open_pdks
cd open_pdks
./configure --enable-sky130-pdk=~/EDA_TOOLS/skywater-pdk/libraries/ \
            --with-sky130-link-targets=source --with-ef-style 
make 
sudo make install 
make distclean
cd ..

echo "#######################################################"
echo "#----------Integrate sky130 to magic VLSI-------------#"
echo "#######################################################"
sudo ln -s /usr/local/share/pdk/sky130A/libs.tech/magic/* /usr/local/lib/magic/sys


echo "#######################################################"
echo "#----------------Installing ngspice-------------------#"
echo "#######################################################"
#install ngspice 
sudo apt-get install -y libtool
git clone https://git.code.sf.net/p/ngspice/ngspice ngspice_test
cd ngspice_test
git pull
git checkout pre-master
./autogen.sh
./configure --with-x --enable-xspice --disable-debug --enable-cider \
	--with-readline=yes --enable-openmp 
make
sudo make install
cd ..

echo "#######################################################"
echo "#--------Setting ngspice simulation mode to HS--------#"
echo "#######################################################"
mkdir ~/.xschem/simulations
cd ~/.xschem/simulations
echo "set ngbehavior=hs" > .spiceinit
cd ~/EDA_TOOLS/


echo "#######################################################"
echo "#--------------------Installing GAW-------------------#"
echo "#######################################################"

sudo apt install -y libgtk-3-dev build-essential
wget http://download.tuxfamily.org/gaw/download/gaw3-20200922.tar.gz
tar -xf gaw3-20200922.tar.gz
cd gaw3-20200922
./configure
make -j$(nproc)
sudo make install
cd ..
echo "#######################################################"
echo "#-------Opening GAW Close it to continue---------------#"
echo "#######################################################"
gaw
echo "#######################################################"
echo "#-------Setting GAW to work with xschem---------------#"
echo "#######################################################"

sed -i 's/up_listenPort = 0/up_listenPort = 2020/' ~/.gaw/gawrc

clear

echo "#######################################################"
echo "#----------------------All Done-----------------------#"
echo "#######################################################"

cd ~/EDA_TOOLS/

