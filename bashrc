#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bashrc.aliases ]
then
	. ~/.bashrc.aliases
fi

if [ -f ~/.ps1.prompt ]
then 
    . ~/.ps1.prompt
fi

export EDITOR=vim
clear; clear

tput setaf 5 && figlet -c "$HOSTNAME"

