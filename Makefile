install: install_osmosis install_upseto_and_solvent install_inaugurator install_yumcache install_rackattack_virtual

install_osmosis:
	cd ../osmosis ; make CONFIGURATION=RELEASE && make install

install_upseto_and_solvent:
	-cd ../solvent ; make uninstall
	-cd ../upseto ; make uninstall
	cd ../upseto ; make
	cd ../solvent ; make
	cd ../upseto ; make install
	cd ../solvent ; make install
	test -e /etc/solvent.conf || sudo cp solvent.conf /etc

install_inaugurator:
	cd ../inaugurator ; make && make install

install_yumcache:
	cd ../yumcache ; make && make install
	sudo cp yumcache.config /etc

install_rackattack_virtual:
	cd ../rackattack-virtual ; make && make install
