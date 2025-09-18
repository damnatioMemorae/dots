#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


# Enables autocompletion of options for bashfuscator
eval "$(/usr/bin/register-python-argcomplete bashfuscator)"
