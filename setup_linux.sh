#!/bin/bash

# New machine installation script
# sudo git clone http://www.github.com/miscuser/dotfiles

# ** add option to install wallpaper


dotfiles_dir=~/dotfiles                           # Dotfiles directory
log_file=~/install_progress_log.txt

# Get started properly by getting correct dotfiles 
echo -n "Would you like to configure your dotfiles (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then
    sudo chmod +x ~/dotfiles/makesymlinks.sh
    sudo ~/dotfiles/makesymlinks.sh
    cd ~
fi

# Prompt to install regularly used packages 
echo -n "Would you like to install all additional packages for this setup (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then

    sudo apt-get -y install pandoc
    if type -p pandoc > /dev/null; then
        echo "Pandoc installed" >> $log_file
    else
        echo "Pandoc FAILED TO INSTALL!!!" >> $log_file
    fi

    sudo apt-get -y install texlive
    if type -p texlive > /dev/null; then
        echo "TexLive installed" >> $log_file
    else
        echo "TexLive FAILED TO INSTALL!!!" >> $log_file
    fi

    sudo apt-get -y install lame
    if type -p lame > /dev/null; then
        echo "Lame installed" >> $log_file
    else
        echo "Lame FAILED TO INSTALL!!!" >> $log_file
    fi

    sudo apt-get -y install vim
    if type -p vim > /dev/null; then
        echo "Vim installed" >> $log_file
    else
        echo "Vim FAILED TO INSTALL!!!" >> $log_file
    fi

    sudo apt-get -y install keepassx
    if type -p keepass2 > /dev/null; then
        echo "Keepass2 Installed" >> $log_file
    else
        echo "Keepass2 FAILED TO INSTALL!!!" >> $log_file
    fi

    sudo apt-get -y install curl
    if type -p curl > /dev/null; then
        echo "curl Installed" >> $log_file
    else
        echo "curl FAILED TO INSTALL!!!" >> $log_file
    fi
    
    sudo apt-get -y install dconf-tools
    if type -p dconf > /dev/null; then
        echo "dconf-tools Installed" >> $log_file
    else
        echo "dconf-tools FAILED TO INSTALL!!!" >> $log_file
    fi
fi

echo -n "Would you like to install SickBeard (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then
    sudo git clone https://github.com/midgetspy/Sick-Beard/ ~/.sickbeard
    wget www.mlinks.net/~cryptor/stuff/init-sickbeard.sh
    sudo mv init.sickbeard.sh /etc/init.d/sickbeard    
    sudo chmod 755 /etc/init.d/sickbeard
    cd /etc/init.d
    sudo update-rc.d sickbeard defaults
    sudo service sickbeard start
    cd ~
fi

echo -n "Would you like to install Virtualbox (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then
    echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib non-free #Virtualbox" > /etc/apt/sources.list.d/virtualbox.list
    wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | apt-key add -
    sudo apt-get -y update
    sudo apt-get -y install virtualbox-4.3
    if [ "`grep vboxusers /etc/group|grep $USER`" == "" ] ; then sudo usermod -G vboxusers -a $USER ; fi
fi

echo -n "Would you like to set additional preferences (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then
    # Change folder view to lists
    sudo gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
fi

# Give a summary of what was installed
echo -e "\n====== Success!! ======\n"
echo -e "\n====== Summary ======\n"
cat $log_file
echo
echo "Enjoy -Misc"
#rm $log_file
