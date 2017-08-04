# useful_scripts
some useful scripts

### .bashrc  (.vimrc is similar)
```shell
cd ~
wget --no-check-certificate https://raw.githubusercontent.com/gaopinghuang0/useful_scripts/master/.bashrc --output-document .bashrc.copy
mv .bashrc.copy .bashrc
source .bashrc

# next time, simply run
syncbashrc
```
