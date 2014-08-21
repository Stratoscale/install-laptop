#!/bin/bash
echo INSTALL-LAPTOP
SUDO=sudo
if [ "$UID" == "0" ]; then
    SUDO=
fi

#osmosis
$SUDO systemctl stop osmosis >& /dev/null
$SUDO cp packages/osmosis.bin /usr/bin/osmosis
if [ "$?" != "0" ]; then exit -1; fi
$SUDO cp etc/osmosis.service /usr/lib/systemd/system/osmosis.service
if [ "$?" != "0" ]; then exit -1; fi
$SUDO systemctl enable osmosis.service
if [ "$?" != "0" ]; then exit -1; fi
$SUDO systemctl start osmosis.service

#upseto
yes | $SUDO pip uninstall upseto >& /dev/null
$SUDO easy_install packages/upseto*.egg
if [ "$?" != "0" ]; then exit -1; fi
$SUDO cp etc/upseto.pth /usr/lib/python2.7/site-packages/upseto.pth
if [ "$?" != "0" ]; then exit -1; fi
$SUDO cp etc/upseto.sh /usr/bin/upseto
if [ "$?" != "0" ]; then exit -1; fi
$SUDO cp etc/upseto.bash.completion.sh /etc/bash_completion.d/upseto.sh
if [ "$?" != "0" ]; then exit -1; fi
$SUDO chmod 755 /usr/bin/upseto
if [ "$?" != "0" ]; then exit -1; fi

#solvent
yes | $SUDO pip uninstall solvent >& /dev/null
$SUDO easy_install packages/solvent*.egg
if [ "$?" != "0" ]; then exit -1; fi
$SUDO cp etc/solvent.sh /usr/bin/solvent
if [ "$?" != "0" ]; then exit -1; fi
$SUDO chmod 755 /usr/bin/solvent
if [ "$?" != "0" ]; then exit -1; fi
$SUDO cp etc/solvent.bash.completion.sh /etc/bash_completion.d/solvent.sh
if [ "$?" != "0" ]; then exit -1; fi
$SUDO cp etc/solvent.conf /etc/solvent.conf -a
if [ "$?" != "0" ]; then exit -1; fi

#inaugurator
$SUDO mkdir /usr/share/inaugurator >& /dev/null
yes | $SUDO pip uninstall inaugurator >& /dev/null
$SUDO easy_install packages/inaugurator*.egg
if [ "$?" != "0" ]; then exit -1; fi
$SUDO cp packages/inaugurator.initrd.img packages/inaugurator.vmlinuz /usr/share/inaugurator
if [ "$?" != "0" ]; then exit -1; fi
$SUDO chmod 644 /usr/share/inaugurator/*
if [ "$?" != "0" ]; then exit -1; fi

#yumcache
$SUDO systemctl stop yumcache >& /dev/null
yes | $SUDO pip uninstall yumcache >& /dev/null
$SUDO easy_install packages/yumcache*.egg
if [ "$?" != "0" ]; then exit -1; fi
$SUDO cp etc/yumcache.service /usr/lib/systemd/system/yumcache.service
if [ "$?" != "0" ]; then exit -1; fi
$SUDO cp etc/yumcache.config /etc/yumcache.config -a
if [ "$?" != "0" ]; then exit -1; fi
$SUDO systemctl enable yumcache.service
if [ "$?" != "0" ]; then exit -1; fi
$SUDO systemctl start yumcache

#rackattack-virtual
$SUDO systemctl stop rackattack-virtual.service >& /dev/null
$SUDO mkdir /usr/share/rackattack.virtual >& /dev/null
$SUDO cp packages/rackattack.virtual.egg /usr/share/rackattack.virtual
if [ "$?" != "0" ]; then exit -1; fi
$SUDO cp etc/rackattack-virtual.service /usr/lib/systemd/system/rackattack-virtual.service
if [ "$?" != "0" ]; then exit -1; fi
$SUDO systemctl enable rackattack-virtual.service
if [ "$?" != "0" ]; then exit -1; fi
$SUDO systemctl start rackattack-virtual

#logbeam
yes | $SUDO pip uninstall logbeam >& /dev/null
$SUDO easy_install packages/logbeam*.egg
if [ "$?" != "0" ]; then exit -1; fi
$SUDO cp etc/logbeam.sh /usr/bin/logbeam
if [ "$?" != "0" ]; then exit -1; fi
$SUDO cp etc/logbeam.bash.completion.sh /etc/bash_completion.d/logbeam.sh
if [ "$?" != "0" ]; then exit -1; fi
$SUDO chmod 755 /usr/bin/logbeam
if [ "$?" != "0" ]; then exit -1; fi

echo "Install-laptop Completed SUCCESSFULLY"
