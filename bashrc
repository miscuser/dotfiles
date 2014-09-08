# Misc bash configuration 

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Editor and display
export EDITOR=vim   # Set the default editor to vim
bind TAB:menu-complete


# History settings
HISTIGNORE="&:ls:[bf]g:exit:lf:ldir"
export HISTCONTROL=ignoredups
shopt -s histverify

# Aliases
alias lf="ls -l | egrep -v '^d'"
alias ldir="ls -l | egrep '^d'"
alias grep='grep --color'
