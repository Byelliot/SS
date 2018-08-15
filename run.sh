#!/usr/bin/env bash
#
# Auto run ssr
#
# System Required:  CentOS 7
#
# Copyright (C) 2016-2018 ECloud <admin@byelliot.top>
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

systemctl stop firewalld.service
cd /root/shadowsocks
./run.sh


echo "已运行"
