setup:
	sudo adduser nimplanet --home /var/lib/nim_planet/ --no-create-home --system
	sudo chown nimplanet /var/lib/nim_planet/
	sudo ln -s $(pwd)/nim_planet.service /lib/systemd/system/
	sudo ln -s $(pwd)/nim_planet.timer /lib/systemd/system/
	sudo systemctl start nim_planet.timer

deploy:
	sudo rsync -avP nim_planet.ini /var/lib/nim_planet/
	sudo rsync -avP asf /var/lib/nim_planet/
	sudo chown nimplanet /var/lib/nim_planet/ -R
	sudo systemctl daemon-reload
	# run immediately
	sudo systemctl restart nim_planet.service
	sudo systemctl restart nim_planet.timer

monitor:
	sudo journalctl --identifier=planet -f
