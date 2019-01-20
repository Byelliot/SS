#!/usr/bin/env bash
#
# Auto install ssr
#
# System Required:  CentOS 7
#
# Copyright (C) 2018 ECloud <admin@byelliot.top>
#
# URL: https://ss.byellio.top
#
get_char() 
{ 
SAVEDSTTY=`stty -g` 
stty -echo 
stty cbreak 
dd if=/dev/tty bs=1 count=1 2> /dev/null 
stty -raw 
stty echo 
stty $SAVEDSTTY 
} 

echo "Press any key to start...or Press Ctrl+C to cancel"

char=`get_char`

wget https://raw.github.com/sivel/speedtest-cli/master/speedtest.py
chmod a+rx speedtest.py
mv speedtest.py /usr/local/bin/speedtest
chown root:root /usr/local/bin/speedtest
echo "已完成"
