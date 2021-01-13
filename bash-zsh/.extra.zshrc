# .extra.zshrc
# This is based on .bashrc
# Author: Gaoping Huang
# Email: gaopinghuang@gmail.com
# Updated date: Jan 12, 2021


# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return


######### general config, for server, bash, cygwin, etc. ########


alias l="ls"
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias ..="cd .."
alias ...="cd ../.."

alias vi="vim"
alias vibash="vi ~/.bashrc"
alias sourcebash="source ~/.bashrc"

# shortcut for git
alias gitst="git status"

# add ssh-key
alias sshmin="ssh huang679@min.ecn.purdue.edu"
alias sshhci="ssh huang679@hci.ecn.purdue.edu"
alias sshee="ssh ee368s2@ecegrid.ecn.purdue.edu"
alias sshlinode="ssh denghuang@104.200.31.91"

# alias python="python -i -u"      # use ipython instead
alias pyserver="python -m SimpleHTTPServer"

# customize settings
# ------------------
# Credit: adapted from https://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux
# detect os platform by `uname -s`, then use corresponding config
case "$(uname -s)" in
  Darwin|Linux )
    # echo 'both'

    alias work="cd ~/Documents/workspace"
    alias workon="source env/bin/activate"  # for virtualenv

    ;;
esac
case "$(uname -s)" in
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
esac
case "$(uname -s)" in

   Darwin)
      # echo 'Mac OS X'

      # npm
      export PATH="$HOME/.node/bin:$PATH"

      # MacPorts Installer addition on 2015-12-23_at_17:45:00: adding an appropriate PATH variable for use with MacPorts.
      export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
      # Finished adapting your PATH environment variable for use with MacPorts.

      # cd then ls 
      function cd {
        builtin cd "$@" && ls -GFh
      }
      
     ;;

   Linux)
      # echo 'Linux'

      # color_prompt
      # Credit: https://askubuntu.com/a/549150
      export PS1="\n\[\e[01;33m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[01;36m\]\h\[\e[0m\]\[\e[00;37m\] \t \[\e[0m\]\[\e[01;35m\]\w\[\e[0m\]\[\e[01;37m\] \[\e[0m\]\n$ "

     ;;

   CYGWIN*|MINGW32*|MSYS*)
      # echo 'MS Windows'

      # For MongoDB mongod, mongodump, and mongo
      export PATH="/cygdrive/c/Program Files/MongoDB/Server/3.4/bin/":$PATH
      # alias mongod-local="mongod --dbpath=f:/mongo_data/data/"
      # alias mongo="C:/Program\ Files/MongoDB/Server/3.2/bin/mongo"

      # color_prompt
      # cygwin's prompt style, simply call `echo $PS1`, addtionally add time by `\t` 
      export PS1="\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \t \[\e[33m\]\w\[\e[0m\]\n\$ "
      
      alias workon="source env/Scripts/activate"  # for virtualenv
      
      # shortcut to kill all windows node.exe, taskkill also works for other exe
      alias killnode="taskkill /F /IM node.exe"


      # For SASS and Compass
      alias sass-w="sass --watch --style expanded"
      alias sass-we="sass-w sass/:css/"
      alias compass="C:/RailsInstaller/Ruby2.1.0/bin/compass"
      alias gem="C:/RailsInstaller/Ruby2.1.0/bin/gem"

      # For java directory
      alias tojava="cd F:/workspace/java"
      alias javac="C:/'Program Files'/Java/jdk1.8.0_51/bin/javac"
      alias java-mine="java -cp lib/antlr.jar';'classes Micro"
      alias java-std="java -cp step7.jar Micro"

      # Some shortcuts to often used directory
      alias work="cd f:/workspace"
      alias story="cd f:/workspace/stories_TBD/story-graph"

      # rerun any code after file modify
      # rerun python test.py
      alias rerun="/cygdrive/f/workspace/rerun/rerun"


      # ssh-pageant for windows
      # see https://github.com/cuviper/ssh-pageant
      eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")


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

     ;;

   # Add here more strings to compare
   # See correspondence table at the bottom of this answer

   *)
     echo 'other OS' 
     ;;
esac

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
