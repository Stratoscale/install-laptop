#!/bin/sh
echo INSTALL-LAPTOP

#osmosis
sudo systemctl stop osmosis
sudo cp packages/osmosis.bin /usr/bin/osmosis
if [ "$?" != "0" ]; then exit -1; fi
sudo cp etc/osmosis.service /usr/lib/systemd/system/osmosis.service
if [ "$?" != "0" ]; then exit -1; fi
sudo systemctl enable osmosis.service
if [ "$?" != "0" ]; then exit -1; fi
sudo systemctl start osmosis.service

#upseto
yes | sudo pip uninstall upseto
sudo easy_install packages/upseto*.egg
if [ "$?" != "0" ]; then exit -1; fi
sudo cp etc/upseto.pth /usr/lib/python2.7/site-packages/upseto.pth
if [ "$?" != "0" ]; then exit -1; fi
sudo cp etc/upseto.sh /usr/bin/upseto
if [ "$?" != "0" ]; then exit -1; fi
sudo cp etc/upseto.bash.completion.sh /etc/bash_completion.d/upseto.sh
if [ "$?" != "0" ]; then exit -1; fi
sudo chmod 755 /usr/bin/upseto
if [ "$?" != "0" ]; then exit -1; fi

#solvent
yes | sudo pip uninstall solvent
sudo easy_install packages/solvent*.egg
if [ "$?" != "0" ]; then exit -1; fi
sudo cp etc/solvent.sh /usr/bin/solvent
if [ "$?" != "0" ]; then exit -1; fi
sudo chmod 755 /usr/bin/solvent
if [ "$?" != "0" ]; then exit -1; fi
sudo cp etc/solvent.bash.completion.sh /etc/bash_completion.d/solvent.sh
if [ "$?" != "0" ]; then exit -1; fi
sudo cp etc/solvent.conf /etc/solvent.conf -a
if [ "$?" != "0" ]; then exit -1; fi

#inaugurator
sudo mkdir /usr/share/inaugurator
yes | sudo pip uninstall inaugurator
sudo easy_install packages/inaugurator*.egg
if [ "$?" != "0" ]; then exit -1; fi
sudo cp packages/inaugurator.initrd.img packages/inaugurator.vmlinuz /usr/share/inaugurator
if [ "$?" != "0" ]; then exit -1; fi
sudo chmod 644 /usr/share/inaugurator/*
if [ "$?" != "0" ]; then exit -1; fi

#yumcache
sudo systemctl stop yumcache
yes | sudo pip uninstall yumcache
sudo easy_install packages/yumcache*.egg
if [ "$?" != "0" ]; then exit -1; fi
sudo cp etc/yumcache.service /usr/lib/systemd/system/yumcache.service
if [ "$?" != "0" ]; then exit -1; fi
sudo cp etc/yumcache.config /etc/yumcache.config -a
if [ "$?" != "0" ]; then exit -1; fi
sudo systemctl enable yumcache.service
if [ "$?" != "0" ]; then exit -1; fi
sudo systemctl start yumcache

#rackattack-virtual
sudo systemctl stop rackattack-virtual.service
sudo mkdir /usr/share/rackattack.virtual
sudo cp packages/rackattack.virtual.egg /usr/share/rackattack.virtual
if [ "$?" != "0" ]; then exit -1; fi
sudo cp etc/rackattack-virtual.service /usr/lib/systemd/system/rackattack-virtual.service
if [ "$?" != "0" ]; then exit -1; fi
sudo systemctl enable rackattack-virtual.service
if [ "$?" != "0" ]; then exit -1; fi
sudo systemctl start rackattack-virtual

echo "Install-laptop Completed SUCCESSFULLY"
