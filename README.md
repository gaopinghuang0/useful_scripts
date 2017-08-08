# useful_scripts
some useful scripts

### .bashrc  (.vimrc is similar)
```shell
wget --no-check-certificate https://raw.githubusercontent.com/gaopinghuang0/useful_scripts/master/.bashrc --output-document .bashrc.new
mv .bashrc.new ~/.bashrc
source ~/.bashrc

# next time, simply run
syncbashrc
```
