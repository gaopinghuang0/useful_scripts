# .bashrc
# Author: Gaoping Huang
# Email: gaopinghuang@gmail.com
# Updated date: Aug 4, 2017


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
alias sshlinode="ssh huang@45.79.68.177"

# alias python="python -i -u"      # use ipython instead
alias pyserver="python -m SimpleHTTPServer"

function syncbashrc {
  wget --no-check-certificate https://raw.githubusercontent.com/gaopinghuang0/useful_scripts/master/.bashrc --output-document .bashrc.new
  mv .bashrc.new ~/.bashrc
  source ~/.bashrc
}

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

   Darwin)   # 'Mac OS X'

      # color_prompt
      export PS1="\n\u@\h:\[\033[33;1m\]\w\[\033[m\]\n\$ "

      # npm
      export PATH="$HOME/.node/bin:$PATH"

      # MacPorts Installer addition on 2015-12-23_at_17:45:00: adding an appropriate PATH variable for use with MacPorts.
      export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
      # Finished adapting your PATH environment variable for use with MacPorts.

      export LSCOLORS=gxfxaxdxcxegedabagacad
      alias ls='ls -GFh'
      alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

      # cd then ls 
      function cd {
        builtin cd "$@" && ls -GFh
      }
      
      function syncbashrc {
        curl https://raw.githubusercontent.com/gaopinghuang0/useful_scripts/master/.bashrc > .bashrc.new
        mv .bashrc.new ~/.bashrc
        source ~/.bashrc
      }
      
     ;;

   Linux)

      # color_prompt
      # Credit: https://askubuntu.com/a/549150
      export PS1="\n\[\e[01;33m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[01;36m\]\h\[\e[0m\]\[\e[00;37m\] \t \[\e[0m\]\[\e[01;35m\]\w\[\e[0m\]\[\e[01;37m\] \[\e[0m\]\n$ "

     ;;

   CYGWIN*|MINGW32*|MSYS*)  # 'MS Windows'
      
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

      alias jekyll="/cygdrive/c/RailsInstaller/Ruby2.1.0/bin/jekyll.bat"
      alias bundle="/cygdrive/c/RailsInstaller/Ruby2.1.0/bin/bundle.bat"
      alias Rscript="/cygdrive/c/'Program Files'/R/R-3.3.0/bin/Rscript.exe"
      alias R="/cygdrive/c/'Program Files'/R/R-3.3.0/bin/R.exe"

      # For sublime text
      alias subl="/cygdrive/c/'Program Files (x86)'/'Sublime Text 3'/subl.exe"

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

