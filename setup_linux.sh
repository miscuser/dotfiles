#!/bin/bash

# New machine installation script
# sudo git clone http://www.github.com/miscuser/dotfiles

# ** add option to install wallpaper

log_file=~/install_progress_log.txt

# Alias dotfiles in home directory 
echo -n "Would you like to configure your symlinks (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then
    sudo chmod +x ~/dotfiles/makesymlinks.sh
    sudo ~/dotfiles/makesymlinks.sh
    cd ~
fi

# Clone other repositories 
echo -n "Would you like to clone your other repos (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then
    git clone git://github.com/miscuser/bin.git ~/bin
    git clone git://github.com/miscuser/colors.git ~/.vim/colors
    git clone git://github.com/miscuser/scripts.git ~/scripts
fi

# Prompt to install regularly used packages 
echo -n "Would you like to install your usual packages (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then

    sudo apt-get -y install avidemux
    if type -p avidemux > /dev/null; then
        echo "avidemux installed" >> $log_file
    else
        echo "avidemux FAILED TO INSTALL" >> $log_file
    fi

    sudo apt-get install libav-tools
    if type -p avconv > /dev/null; then
        echo "libav-tools installed" >> $log_file
    else
        echo "libav-tools FAILED TO INSTALL" >> $log_file
    fi

    sudo apt-get install dos2unix
    if type -p dos2unix > /dev/null; then
        echo "dos2unix installed" >> $log_file
    else
        echo "dos2unix FAILED TO INSTALL" >> $log_file
    fi

    sudo apt-get -y install pandoc
    if type -p pandoc > /dev/null; then
        echo "Pandoc installed" >> $log_file
    else
        echo "Pandoc FAILED TO INSTALL" >> $log_file
    fi

    sudo apt-get -y install texlive-full
    if type -p texlive > /dev/null; then
        echo "TexLive installed" >> $log_file
    else
        echo "TexLive FAILED TO INSTALL" >> $log_file
    fi

    sudo apt-get -y install lame
    if type -p lame > /dev/null; then
        echo "Lame installed" >> $log_file
    else
        echo "Lame FAILED TO INSTALL" >> $log_file
    fi

    sudo apt-get -y install vim
    if type -p vim > /dev/null; then
        echo "Vim installed" >> $log_file
    else
        echo "Vim FAILED TO INSTALL" >> $log_file
    fi

    sudo apt-get -y install keepassx
    if type -p keepassx > /dev/null; then
        echo "keepassx installed" >> $log_file
    else
        echo "keepassx FAILED TO INSTALL" >> $log_file
    fi

    sudo apt-get -y install curl
    if type -p curl > /dev/null; then
        echo "curl installed" >> $log_file
    else
        echo "curl FAILED TO INSTALL" >> $log_file
    fi
    
    sudo apt-get -y install dconf-tools
    if type -p dconf > /dev/null; then
        echo "dconf-tools installed" >> $log_file
    else
        echo "dconf-tools FAILED TO INSTALL" >> $log_file
    fi

    sudo apt-get install silversearcher-ag
    if type -p ag > /dev/null; then
        echo "Silver Searcher installed" >> $log_file
    else
        echo "Silver Searcher FAILED TO INSTALL" >> $log_file
    fi

    sudo apt-get install tmux
    if type -p tmux > /dev/null; then
        echo "tmux installed" >> $log_file
    else
        echo "tmux FAILED TO INSTALL" >> $log_file
    fi

    # Install ffmpeg from different ppa
    sudo apt-add-repository ppa:mc3man/trusty-media
    sudo apt-get update
    sudo apt-add-repository --remove ppa:mc3man/trusty-media

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
    gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
    gsettings set org.gnome.nautilus.preferences executable-text-activation launch

fi

echo -n "Would you like to swap CAPS and CTRL by inserting "ctrl:swapcaps" (Y/n) => "; read answer
if [[ $answer = "Y" ]] ; then
    sudo vim /etc/default/keyboard
    sudo dpkg-reconfigure keyboard-configuration
fi

# Display results 
echo -e "\n====== Summary ======\n"
cat $log_file
