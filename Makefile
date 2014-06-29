all: install_here build test

test: build
	cd build/install-laptop ; ./install.sh

.PHONY: build
build: build/installer/install-laptop.tgz

build/installer/install-laptop.tgz:
	-rm -fr build/install-laptop*
	-mkdir -p build/install-laptop/packages
	-mkdir -p build/install-laptop/etc
	-mkdir -p build/installer
	cp ../osmosis/build/cpp/osmosis.bin build/install-laptop/packages -a
	cp ../osmosis/osmosis.service build/install-laptop/etc -a
	cp ../upseto/dist/*.egg build/install-laptop/packages -a
	cp ../upseto/upseto.pth build/install-laptop/etc -a
	cp ../upseto/upseto.sh build/install-laptop/etc -a
	cp ../solvent/dist/*.egg build/install-laptop/packages -a
	cp ../solvent/solvent.sh build/install-laptop/etc -a
	cp solvent.conf build/install-laptop/etc -a
	cp ../inaugurator/dist/*.egg build/install-laptop/packages -a
	cp ../inaugurator/build/inaugurator.initrd.img ../inaugurator/build/inaugurator.vmlinuz build/install-laptop/packages -a
	cp ../yumcache/dist/*.egg build/install-laptop/packages -a
	cp ../yumcache/yumcache.service build/install-laptop/etc/ -a
	cp yumcache.config build/install-laptop/etc -a
	cp ../rackattack-virtual/build/*.egg build/install-laptop/packages -a
	cp ../rackattack-virtual/rackattack-virtual.service build/install-laptop/etc -a
	cp install.sh build/install-laptop/ -a
	chmod 755 build/install-laptop/install.sh
	tar -czf $@ -C build install-laptop

submit: build/installer/install-laptop.tgz
	solvent submitproduct installer `dirname $<`

.PHONY: install_here
install_here: install_osmosis install_upseto_and_solvent install_inaugurator install_yumcache install_rackattack_virtual

install_osmosis:
	cd ../osmosis ; DONT_START_SERVICE=yes make install

install_upseto_and_solvent:
	-cd ../solvent ; make uninstall
	-cd ../upseto ; make uninstall
	cd ../upseto ; make install
	cd ../solvent ; make install
	test -e /etc/solvent.conf || sudo cp solvent.conf /etc

install_inaugurator:
	cd ../inaugurator ; make install

install_yumcache:
	cd ../yumcache ; DONT_START_SERVICE=yes make install
	sudo cp yumcache.config /etc

install_rackattack_virtual:
	cd ../rackattack-virtual ; DONT_START_SERVICE=yes make install
