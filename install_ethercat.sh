#!/bin/bash

set -e

# enable pulling sources
sed -i '/^#\sdeb-src /s/^# *//' "/etc/apt/sources.list"
sudo apt update
sudo apt source linux-image-$(uname -r)

cd /workspaces/pandora-workspace/src/ethercat_driver_ros2
./bootstrap
./configure --prefix=/usr/local/etherlab  --disable-8139too --enable-generic --with-linux-dir
make all modules
sudo make modules_install install
sudo depmod
sudo ln -s /usr/local/etherlab/bin/ethercat /usr/bin/
sudo ln -s /usr/local/etherlab/etc/init.d/ethercat /etc/init.d/ethercat
sudo cp /usr/local/etherlab/etc/sysconfig/ethercat /etc/sysconfig/ethercat
sudo echo KERNEL==\"EtherCAT[0-9]*\", MODE=\"0664\", GROUP=\"ecusers\" > /etc/udev/rules.d/99-EtherCAT.rules
