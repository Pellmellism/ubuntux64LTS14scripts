#!/bin/bash
#http://howtoubuntu.org/things-to-do-after-installing-ubuntu-14-04-trusty-tahr

#something to enable partner repos...http://askubuntu.com/a/51244
sed -i "/^# deb .*partner/ s/^# //" /etc/apt/sources.list && apt-get update

#check if we are in VirtualBox to install guest additions
#list all PCI devices and search for the word VirtualBox
if lspci | grep "VirtualBox" --quiet; then
  echo "install guest additions the right way"
	sudo mount /dev/cdrom /mnt
	cd /mnt
	sudo ./VBoxLinuxAdditions.run

  #for accessing shared folder
  sudo adduser $USER vboxsf
else
  echo "Not a VirtualBox instance"
fi

#Download and install GetDeb and PlayDeb
echo "Downloading GetDeb and PlayDeb" &&
wget http://archive.getdeb.net/install_deb/getdeb-repository_0.1-1~getdeb1_all.deb http://archive.getdeb.net/install_deb/playdeb_0.3-1~getdeb1_all.deb &&

echo "Installing GetDeb" &&
sudo dpkg -i getdeb-repository_0.1-1~getdeb1_all.deb &&

echo "Installing PlayDeb" &&
sudo dpkg -i playdeb_0.3-1~getdeb1_all.deb &&

echo "Deleting Downloads" &&
rm -f getdeb-repository_0.1-1~getdeb1_all.deb &&
rm -f playdeb_0.3-1~getdeb1_all.deb

#add Personal Package Archives
sudo add-apt-repository -y ppa:videolan/stable-daily
sudo add-apt-repository -y ppa:otto-kesselgulasch/gimp
sudo add-apt-repository -y ppa:gnome3-team/gnome3
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:webupd8team/y-ppa-manager
sudo add-apt-repository ppa:webupd8team/atom
echo 'deb http://download.videolan.org/pub/debian/stable/ /' | sudo tee -a /etc/apt/sources.list.d/libdvdcss.list &&
echo 'deb-src http://download.videolan.org/pub/debian/stable/ /' | sudo tee -a /etc/apt/sources.list.d/libdvdcss.list &&
wget -O - http://download.videolan.org/pub/debian/videolan-apt.asc|sudo apt-key add -

#check for updates
sudo apt-get update

#upgrade packages
sudo apt-get upgrade

#major upgrades
sudo apt-get dist-upgrade

#install essentials
#added git, RabbitVCS needs it...
#added npm
#added atom.io text editor
sudo apt-get install gcc build-essential python-dev python3-dev python-pip vim-gtk git atom curl synaptic vlc gimp gimp-data gimp-plugin-registry gimp-data-extras y-ppa-manager bleachbit openjdk-7-jre oracle-java8-installer flashplugin-installer unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller libxine1-ffmpeg mencoder flac faac faad sox ffmpeg2theora libmpeg2-4 uudeview libmpeg3-1 mpeg3-utils mpegdemux liba52-dev mpeg2dec vorbis-tools id3v2 mpg321 mpg123 libflac++6 totem-mozilla icedax lame libmad0 libjpeg-progs libdvdcss2 libdvdread4 libdvdnav4 libswscale-extra-2 ubuntu-restricted-extras ubuntu-wallpapers*

sudo pip install virtualenvwrapper
echo -e "\nsource `which virtualenvwrapper.sh`" >> ~/.bashrc
mkvirtualenv pycloak --python=`which python3`
workon pycloak
pip install wheel
pip install --upgrade setuptools
pip install --upgrade pip
#pip install -r misc/freeze.txt

#do something to install additional drivers

#Install Google Chrome
if [[ $(getconf LONG_BIT) = "64" ]]
then
	echo "64bit Detected" &&
	echo "Installing Google Chrome" &&
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
	sudo dpkg -i google-chrome-stable_current_amd64.deb &&
	rm -f google-chrome-stable_current_amd64.deb
else
	echo "32bit Detected" &&
	echo "Installing Google Chrome" &&
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb &&
	sudo dpkg -i google-chrome-stable_current_i386.deb &&
	rm -f google-chrome-stable_current_i386.deb
fi

#cleanup
echo "Cleaning Up" &&
sudo apt-get -f install &&
sudo apt-get autoremove &&
sudo apt-get -y autoclean &&
sudo apt-get -y clean

#install RabbitVCS
#restart after for nautulis to refresh
#a mashup of http://wiki.rabbitvcs.org/wiki/install/ubuntu
#and http://howtoubuntu.org/things-to-do-after-installing-ubuntu-14-04-trusty-tahr
sudo add-apt-repository ppa:rabbitvcs/ppa
sudo apt-get update
sudo apt-get install rabbitvcs-nautilus3 #for nautilus 3.x
#sudo apt-get install rabbitvcs-nautilus #for nautilus 2.x
#sudo apt-get install rabbitvcs-thunar   #for thunar extensions
sudo apt-get install rabbitvcs-gedit     #for gedit extensions
sudo apt-get install rabbitvcs-cli       #for commandline launchers
sudo ln -sf /usr/lib/x86_64-linux-gnu/libpython2.7.so.1.0 /usr/lib/
sudo ln -sf /usr/lib/x86_64-linux-gnu/libpython2.7.so.1 /usr/lib/
wget http://rabbitvcs.googlecode.com/svn/trunk/clients/nautilus-3.0/RabbitVCS.py  /usr/share/nautilus-python/extensions
chown -R $USER:$USER ~/.config/rabbitvcs


# install Node and npm and electron
sudo apt-get install curl
curl --silent --location https://deb.nodesource.com/setup_4.x | sudo bash -
sudo apt-get install nodejs
sudo npm install npm -g
sudo npm install electron-prebuilt -g
