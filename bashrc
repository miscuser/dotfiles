# Misc bash configuration 

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

#===============================================================================
#  Editor and display
#===============================================================================
export EDITOR=vim  

#===============================================================================
#  History settings
#===============================================================================
HISTIGNORE="&:ls:[bf]g:exit:lf:ldir"
export HISTCONTROL=ignoredups
shopt -s histverify
export HISTSIZE= 
export HISTFILESIZE=
#export HISTTIMEFORMAT="[%F %T] "
export HISTTIMEFORMAT="[%F] "

#===============================================================================
#  Key bindings
#===============================================================================
bind '"\e[A":history-search-backward'    # arrow keys for history search
bind '"\e[B":history-search-forward'     # arrow keys for history search
bind TAB:menu-complete

#===============================================================================
#  Aliases
#===============================================================================
alias lf="ls -l | egrep -v '^d'"
alias ldir="ls -l | egrep '^d'"
alias ll='ls -lh'
alias la='ls -la'
alias lls='ls -lhSR'
alias lla='ls -laSR'
alias grep='grep --color'
alias vom='vim'
alias vimr='vim -M'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias gc='git commit -m'
alias ga='git add'
alias push='git push origin master'
alias pull='git pull'
alias bye='sudo shutdown -h now'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias upgrade='sudo apt-get upgrade'
alias clean='sudo apt-get autoclean && sudo apt-get autoremove'
alias mini='sudo service minidlna force-reload'
alias home='cd ~'
# work only
alias code='cd /cygdrive/c/home/code'
alias ocz='/cygdrive/c/home/code/OneCard/OneCard_Extract_Zipper.sh'


#===============================================================================
# FUNCTIONS
#===============================================================================

#-------------------------------------------------------------------------------
#  Prints out my alias commands and functions
#-------------------------------------------------------------------------------
function custom() {
    echo "###########  ALIASES  ############"
    echo "       bye <<-- shut down the computer"
    echo "    update <<-- sudo apt-get update && sudo apt-get upgrade"
    echo "   upgrade <<-- sudo apt-get upgrade"
    echo "     clean <<-- sudo apt-get autoclean && sudo apt-get autoremove"
    echo "        gc <<-- git commit -m"
    echo "        ga <<-- git add"
    echo "      pull <<-- git pull"
    echo "      push <<-- git push origin master"
    echo "      mini <<-- restart minidlna"
    echo ""
    echo "###########   WORK   #############" 
    echo "       ocz <<-- OneCard zipper - archives extract files"
    echo "      code <<-- change to code directory"
    echo "     phone <<-- search for phone number"
    echo ""
    echo "###########  FUNCTIONS  ############"
    echo "   extract <<-- extract the most common compression types"
    echo "   nightly <<-- run nightly backup"
    echo "     mvnzb <<-- move nzb files to correct directory"
    echo "        ff <<-- find file with pattern in name"
    echo "        fd <<-- find directory with pattern in name"
    echo "        dl <<-- change to download folder"
    echo "         c <<-- clear the terminal screen"
}

#-------------------------------------------------------------------------------
#  Runs nightly backup 
#-------------------------------------------------------------------------------
function nightly()
{
    /home/misc/scripts/nightly_backup.sh
}

#-------------------------------------------------------------------------------
#  Change to download folder 
#-------------------------------------------------------------------------------
function dl()
{
    if [ "$(uname)" == "Darwin" ] ; then
        echo "You need to set the path"
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ] ; then
        cd ~/Downloads
    elif [ "$(expr substr $(uname -s) 1 6)" == "CYGWIN" ] ; then
        cd  /cygdrive/c/users/100219278/Downloads
    fi
}

#-------------------------------------------------------------------------------
#  Search for phone number 
#-------------------------------------------------------------------------------
function phone()
{
    if [ "$(uname)" == "Darwin" ] ; then
        pfile='phone.txt'
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ] ; then
        pfile='phone.txt'
    elif [ "$(expr substr $(uname -s) 1 6)" == "CYGWIN" ] ; then
        pfile='/cygdrive/c/home/reference/phone.txt'
    fi
    
    if [ -f $pfile ] ; then
        grep -i $1 $pfile 
    else
        echo "$pfile does not exist"
    fi
}

#-------------------------------------------------------------------------------
# Extract the most commmon compression types
#-------------------------------------------------------------------------------
function extract()
{
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xvjf "$1"     ;;
            *.tar.gz)    tar xvzf "$1"     ;;
            *.bz2)       bunzip2 "$1"      ;;
            *.rar)       unrar x "$1"      ;;
            *.gz)        gunzip "$1"       ;;
            *.tar)       tar xvf "$1"      ;;
            *.tbz2)      tar xvjf "$1"     ;;
            *.tgz)       tar xvzf "$1"     ;;
            *.zip)       unzip "$1"        ;;
            *.Z)         uncompress "$1"   ;;
            *.7z)        7z x "$1"         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

#-------------------------------------------------------------------------------
# Find a file with pattern in name 
#-------------------------------------------------------------------------------
function ff() 
{ 
    # Find files and omit errors (e.g. permission denied)
    find . -type f -iname '*'"$*"'*' -ls 2>/dev/null 
}

#-------------------------------------------------------------------------------
# Find a directory with pattern in name 
#-------------------------------------------------------------------------------
function fd() 
{ 
    # Find directories and omit errors (e.g. permission denied)
    find . -type d -iname '*'"$*"'*' -ls 2>/dev/null 
}

#-------------------------------------------------------------------------------
# Clear the screen - handle all environments
#-------------------------------------------------------------------------------
function c()
{
    if [ "$(uname)" == "Darwin" ]; then
        clear
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        clear
    elif [ "$(expr substr $(uname -s) 1 6)" == "CYGWIN" ]; then
        printf "\033c"
    fi
}

#-------------------------------------------------------------------------------
# Move nzb files to proper directory
#-------------------------------------------------------------------------------
function mvnzb()
{
    if [ "$(uname)" == "Darwin" ]; then
        echo "configure this"
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        mv ~/Downloads/*.nzb ~/Downloads/nzb
    elif [ "$(expr substr $(uname -s) 1 6)" == "CYGWIN" ]; then
        echo "configure this"
    fi
}
