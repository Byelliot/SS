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

cd /root
yum -y groupinstall "Development Tools"
wget https://github.com/jedisct1/libsodium/releases/download/1.0.16/libsodium-1.0.16.tar.gz
tar xf libsodium-1.0.16.tar.gz && cd libsodium-1.0.16
./configure && make -j2 && make install
echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf
ldconfig
cd /root
yum -y install python-setuptools
easy_install pip
git clone -b manyuser https://github.com/glzjin/shadowsocks.git
cd shadowsocks
pip install -r requirements.txt
cp apiconfig.py userapiconfig.py
cp config.json user-config.json
cd /etc/systemd/system/
wget https://raw.githubusercontent.com/Byelliot/SS/master/ssr.service
systemctl enable ssr
echo "已完成"
