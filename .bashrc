# Misc's bash configuration

#===============================================================================
#  Common settings.
#===============================================================================
# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Get machine customizations.
if [ -f "${HOME}/dotfiles/.bash_machines" ] ; then
    source "${HOME}/dotfiles/.bash_machines"
fi

# Load custom functions.
if [ -f "${HOME}/dotfiles/.bash_functions" ] ; then
    source "${HOME}/dotfiles/.bash_functions"
fi

# Load custom functions.
if [ -f "${HOME}/dotfiles/.whip_aliases" ] ; then
    source "${HOME}/dotfiles/.whip_aliases"
fi

export EDITOR=vim
# black 30, blue 34, green 32, cyan 36, red 31, purple 35, brown 33, blue 34
# use \$PWD instead of \w to get full path
export PS1="\[\e]0;\w\a\]\n\[\e[1;32m\]\u@\h \[\e[1;36m\]\w\[\e[0m\]\n\$ "
PATH=$PATH:~/bin
export TERM=xterm-256color
IGNOREEOF=2                         # shell exists after 2nd consecutive Ctrl-d

#===============================================================================
#  History settings
#===============================================================================
#  Ignore some of the short commands I use frequently.
export HISTIGNORE="&:exit:\
nightly:push:pull:history:bash:ocz:renew:\
rmdir:\
vim:vimr:vimR:\
task:\
o:\
testing:dl:dots:code:home:drop:\
yt:ytd:gs:gc*:\
log_work:custom:phone*:\
tm:tlist:\
ago:\
c:la:ls:bg:bf:ll:lla:lf:lt:ldir:thor"
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=100000
export HISTFILESIZE=500000
shopt -s histappend
shopt -s histverify

#===============================================================================
#  Key bindings
#===============================================================================
bind '"\e[A":history-search-backward'    # arrow keys for history search
bind '"\e[B":history-search-forward'     # arrow keys for history search
bind TAB:menu-complete

#===============================================================================
#  Aliases
#===============================================================================
# general file listing
alias ls='ls --color'
alias lt='ls -ltr'
alias lf="ls -l | egrep -v '^d'"
alias ldir="ls -l | egrep '^d'"
alias ll='ls -lh'
alias la='ls -la'
alias lls='ls -lhSR'
alias lla='ls -laSR'
alias thor='ls -thor'
alias grep='grep --color'
alias histoff='set +o history'
alias histon='set -o history'

# alias functions and scripts
alias mdcd='mkdircd'
alias o='open'
alias c='clear-screen'

# save file instead of deleting it
alias trash='mv -t ~/.trash --backup=t'

# open vim in read-only mode -M modify; -R read-only
alias vimr='vim -M'
alias vimR='vim -R'

# make directory traversal easier
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
shopt -s autocd
complete -d cd

# common typos
alias vom='vim'
alias wim='vim'
alias cd..='cd ..'
alias o.='o .'
alias youtube-dl='youtube-dl.exe'

# change to commonly used directories
alias home='cd ~'
alias dots='cd ~/dotfiles'

# git
alias gc='git commit -m'
alias ga='git add'
alias gs='git status'
alias grefresh='git ls-files -d | xargs git checkout --'
alias push='git push origin master'
alias pull='git pull origin master'

# tmux
alias tlist='tmux list-sessions'
alias tat='tmux attach -t $1'
alias tnew='tmux new-session -s $1'
alias tkill='tmux kill-session -t $1'
