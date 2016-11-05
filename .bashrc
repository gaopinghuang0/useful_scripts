# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# base-files version 4.2-3

# ~/.bashrc: executed by bash(1) for interactive shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
# shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell

# Completion options
#
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# [[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options
#
# Don't put duplicate lines in the history.
# export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Aliases
#
# Some people use a different file for aliases
# if [ -f "${HOME}/.bash_aliases" ]; then
#   source "${HOME}/.bash_aliases"
# fi
#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#
# Default to human readable figures
# alias df='df -h'
# alias du='du -h'
#
# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
# alias grep='grep --color'                     # show differences in colour
# alias egrep='egrep --color=auto'              # show differences in colour
# alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
# alias ls='ls -hF --color=tty'                 # classify files in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'


LS_COLORS='di=1;33:ex=1;32'
export LS_COLORS
alias l="ls"
alias ls="ls --color=auto --group-directories-first"
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias ..="cd .."
alias ...="cd ../.."

alias vi="vim"
alias python="python -i -u"
alias vibash="vi ~/.bashrc"
alias sshmin="ssh huang679@min.ecn.purdue.edu"
alias sshhci="ssh huang679@hci.ecn.purdue.edu"

# For MongoDB mongod, mongodump, and mongo
export PATH="/cygdrive/c/Program Files/MongoDB/Server/3.2/bin/":$PATH
# alias mongod="C:/Program\ Files/MongoDB/Server/3.2/bin/mongod"
# alias mongo="C:/Program\ Files/MongoDB/Server/3.2/bin/mongo"

# For SASS and Compass
alias sass-w="sass --watch --style expanded"
alias sass-we="sass-w sass/:css/"
alias compass="C:/RailsInstaller/Ruby2.1.0/bin/compass"
alias gem="C:/RailsInstaller/Ruby2.1.0/bin/gem"

# For java directory
alias tojava="cd F:/Eclipse_workspace/java"
alias javac="C:/'Program Files'/Java/jdk1.8.0_51/bin/javac"
alias java-mine="java -cp lib/antlr.jar';'classes Micro"
alias java-std="java -cp step7.jar Micro"

# cd then ls 
function cd {
    builtin cd "$@" && ls -F
    }

# Some shortcuts to often used directory
alias elist="cd f:/Eclipse_workspace/eList/eList_v03_webpy_jinja"
alias web="cd f:/Eclipse_workspace/learn_web_python/"
alias angular="cd f:/Eclipse_workspace/myangularjs/"
alias blog="cd f:/Eclipse_workspace/learn_web_python/homepage-and-blog/gaoping-blog/"
alias work="cd f:/Eclipse_workspace"

# rerun any code after file modify
# rerun python test.py
alias rerun="/cygdrive/f/Eclipse_workspace/rerun/rerun"

LS_COLORS='di=1;33:ex=1;32'
export LS_COLORS

# shortcut for git
alias gitst="git status"

# add ssh-key
alias addssh="ssh-add ~/.ssh/id_rsa"

# set SVN editor
# export SVN_EDITOR=vim 
# Sublime_text cannot be svn-editor because when it opens, the connection between
# svn and editor is closed and will create a useless "svn-prop.tmp" file
# export SVN_EDITOR="C:/'Program Files (x86)'/'Sublime Text 3'/sublime_text.exe"
export SVN_EDITOR="C:/Windows/system32/notepad.exe"
alias svn-ignore="svn propedit svn:ignore ."
alias svn-get="svn propget svn:ignore . > temp-svn-ignore"
alias svn-set="svn propset svn:ignore -F temp-svn-ignore . ; rm temp-svn-ignore"
alias svn-log="svn log -r 1:HEAD"
alias svn-revert="svn revert data/elist.sandbox.sqlite"


# Colorize SVN
# ------------
# Adds color to the output of commands like svn status and svn update.
# The original version of the script was posted by Ash_ on Stackoverflow
# Source: http://stackoverflow.com/questions/8786400/svn-add-colors-on-command-line-svn-with-awk-in-bash
function svn {
  # Skip the color script when running an svn commit.
  if [ "x$1" = "xci" ] || [ "x$1" =  "xcommit" ] || [ "x$1" = "xadd" ]
  then
    command svn "$@";
    return;
  fi

  # Pipe svn through awk to colorize its output.
  command svn "$@" | awk '
  BEGIN {
    cpt_c=0;
  }
  {
    if        ($1=="C") {
      cpt_c=cpt_c+1;
      print "\033[31m" $0 "\033[00m";  # Conflicts are displayed in red
    }
    else if   ($1=="M") {
      print "\033[31m" $0 "\033[00m";  # Modified in red
    }
    else if   ($1=="A") {
      print "\033[32m" $0 "\033[00m";  # Add in green
    }
    else if   ($1=="?") {
      print "\033[36m" $0 "\033[00m";  # New in cyan
    }
    else if   ($1=="D") {
      print "\033[31m" $0 "\033[00m";  # Delete in red
    }
    else if   ($1=="U") {
      print "\033[35m" $0 "\033[00m";  # Updated in light magenta
    }
    else if   ($1=="X") {
      print "\033[33m" $0 "\033[00m";  # No changes in yellow.
    }
    else if   ($1=="At" || $1 == "External") {
      print "\033[33m" $0 "\033[00m";  # Revision numbers in brown.
    }
    else                {
      print $0;                        # No color, just print the line
    }
  }
  END {
    print cpt_c, " conflicts are found.";
  }';
}

# The colors are basically bright-yellow (33;01) for all dirs, 
# red (31) for executable files and default (00) for all other files and text.
# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#
# Some example functions:
#
# a) function settitle
# settitle () 
# { 
#   echo -ne "\e]2;$@\a\e]1;$@\a"; 
# }
# 
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
# cd_func ()
# {
#   local x2 the_new_dir adir index
#   local -i cnt
# 
#   if [[ $1 ==  "--" ]]; then
#     dirs -v
#     return 0
#   fi
# 
#   the_new_dir=$1
#   [[ -z $1 ]] && the_new_dir=$HOME
# 
#   if [[ ${the_new_dir:0:1} == '-' ]]; then
#     #
#     # Extract dir N from dirs
#     index=${the_new_dir:1}
#     [[ -z $index ]] && index=1
#     adir=$(dirs +$index)
#     [[ -z $adir ]] && return 1
#     the_new_dir=$adir
#   fi
# 
#   #
#   # '~' has to be substituted by ${HOME}
#   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"
# 
#   #
#   # Now change to the new dir and add to the top of the stack
#   pushd "${the_new_dir}" > /dev/null
#   [[ $? -ne 0 ]] && return 1
#   the_new_dir=$(pwd)
# 
#   #
#   # Trim down everything beyond 11th entry
#   popd -n +11 2>/dev/null 1>/dev/null
# 
#   #
#   # Remove any other occurence of this dir, skipping the top of the stack
#   for ((cnt=1; cnt <= 10; cnt++)); do
#     x2=$(dirs +${cnt} 2>/dev/null)
#     [[ $? -ne 0 ]] && return 0
#     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
#     if [[ "${x2}" == "${the_new_dir}" ]]; then
#       popd -n +$cnt 2>/dev/null 1>/dev/null
#       cnt=cnt-1
#     fi
#   done
# 
#   return 0
# }
# 
# alias cd=cd_func
export TERM=cygwin 
export TERM=cygwin 

