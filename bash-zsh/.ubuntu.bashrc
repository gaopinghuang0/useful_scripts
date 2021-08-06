# .bashrc
# Author: Gaoping Huang
# Email: gaopinghuang@gmail.com
# Updated date: Aug 4, 2017


# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


######### general config, for server, bash, cygwin, etc. ########

alias vi="vim"
alias vibash="vi ~/.bashrc"
alias sourcebash="source ~/.bashrc"

# shortcut for git
alias gitst="git status"

# shortcut for common directories
alias work="cd /mnt/d/ws"

### color_prompt
# Credit: https://askubuntu.com/a/549150
export PS1="\n\[\e[01;33m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[01;36m\]\h\[\e[0m\]\[\e[00;37m\] \t \[\e[0m\]\[\e[01;35m\]\w\[\e[0m\]\[\e[01;37m\] \[\e[0m\]\n$ "

### ls

alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias ..="cd .."
alias ...="cd ../.."
# di: directroy; ex: executable; 1: bold; 32: green; 33: yellow; 36: cyan;
export LS_COLORS='di=1;36:ex=1;32:ow=01;34'  # colorize output from running `ls`
alias ls="ls -F --color=auto --group-directories-first"
# cd then ls 
function cd {
    builtin cd "$@" && ls -F --color=auto --group-directories-first
}
