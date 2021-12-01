#!/bin/sh
# 杀掉进程并重启flask server
# Usage: ./restart_server.sh folder/flask_server.py

# Find and kill a process by name
# See: https://stackoverflow.com/questions/3510673/find-and-kill-a-process-in-one-line-using-bash-and-regex
# [p]ython is a trick to stop picking up the `grep` process itself.
# `$1` is like `folder/flask_server.py`
kill $(ps aux | grep "[p]ython $1" | awk '{print $2}')

source venv/bin/activate
export PYTHONPATH=.
nohup python $1 &
