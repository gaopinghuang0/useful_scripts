# .extra.zshrc
# This is based on .bashrc
# Author: Gaoping Huang
# Email: gaopinghuang@gmail.com
# Updated date: Oct 28, 2021

### ls

alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias ..="cd .."
alias ...="cd ../.."


# shortcut for git
alias gitst="git status"
# shortcut for common directories
alias work="cd ~/Documents/ws"


# customize settings
# ------------------
# Credit: adapted from https://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux
# detect os platform by `uname -s`, then use corresponding config
case "$(uname -s)" in
   Darwin)
      # echo 'Mac OS X'

      # cd then ls 
      function cd {
        builtin cd "$@" && ls -GFh
      }

     ;;

  Linux|CYGWIN*|MINGW32*|MSYS* )
    # echo 'both'

    # di: directroy; ex: executable; 1: bold; 32: green; 33: yellow; 36: cyan;
    export LS_COLORS='di=1;36:ex=1;32'  # colorize output from running `ls`
    alias ls="ls --color=auto --group-directories-first"
    # cd then ls 
    function cd {
      builtin cd "$@" && ls -F --color=auto --group-directories-first
    }

    ;;

  *)
    echo 'other OS' 
     ;;
esac
