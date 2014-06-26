install: install_osmosis install_upseto_and_solvent install_inaugurator install_yumcache install_rackattack_virtual

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
