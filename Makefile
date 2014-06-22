install: install_yumcache install_upseto install_osmosis

install_yumcache:
	cd yumcache ; git fetch && git rebase
	cd yumcache ; make install
	sudo cp yumcache.config /etc/yumcache.config
	sudo systemctl stop yumcache
	sudo systemctl start yumcache

install_upseto:
	cd upseto ; git fetch && git rebase
	cd upseto ; make install

install_osmosis:
	#cd osmosis ; git fetch && git rebase
	cd osmosis ; make clean && make CONFIGURATION=RELEASE && make install
