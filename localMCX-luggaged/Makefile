include /usr/local/share/luggage/luggage.make
TITLE=LocalMCXstarter
REVERSE_DOMAIN=com.afp548.LocalMCX-starter.pkg
PAYLOAD=pack-usr-local-sbin-networkCheckers.py \
pack-Library-LaunchDaemons-com.afp548.localMCX-fixMACaddy.plist \
pack-Library-LaunchDaemons-com.afp548.LocalMCX-fixSearchPath.plist \
pack-Library-LaunchDaemons-com.afp548.networkingUp.plist \
pack-usr-local-sbin-fixComputerRecord.sh \
pack-usr-local-sbin-LocalMCX-fixSearchPath.sh \
pack-var-db-dslocal-nodes-MCX-computers-local_desktop.plist \
pack-var-db-dslocal-nodes-MCX-computers-local_laptop.plist \
pack-var-db-dslocal-nodes-MCX-computergroups-login_window_show_textfieldsmessage.plist

prep-var-db-dslocal-nodes-MCX-computers:
	@sudo mkdir -p ${WORK_D}/var/db/dslocal/nodes/MCX/computers
	@sudo chown root:wheel ${WORK_D}/var/db/dslocal/nodes/MCX/computers
	@sudo chmod 700 ${WORK_D}/var/db/dslocal/nodes/MCX/computers

prep-var-db-dslocal-nodes-MCX-computergroups:
	@sudo mkdir -p ${WORK_D}/var/db/dslocal/nodes/MCX/computergroups
	@sudo chown root:wheel ${WORK_D}/var/db/dslocal/nodes/MCX/computergroups
	@sudo chmod 700 ${WORK_D}/var/db/dslocal/nodes/MCX/computergroups

pack-var-db-dslocal-nodes-MCX-computers-local_desktop.plist: prep-var-db-dslocal-nodes-MCX-computers local_desktop.plist
	@sudo ${INSTALL} -m 600 -o root -g wheel local_desktop.plist ${WORK_D}/var/db/dslocal/nodes/MCX/computers/local_desktop.plist

pack-var-db-dslocal-nodes-MCX-computers-local_laptop.plist: prep-var-db-dslocal-nodes-MCX-computers local_laptop.plist
	@sudo ${INSTALL} -m 600 -o root -g wheel local_laptop.plist ${WORK_D}/var/db/dslocal/nodes/MCX/computers/local_laptop.plist

pack-var-db-dslocal-nodes-MCX-computergroups-login_window_show_textfieldsmessage.plist: prep-var-db-dslocal-nodes-MCX-computergroups login_window_show_textfieldsmessage.plist
	@sudo ${INSTALL} -m 600 -o root -g wheel login_window_show_textfieldsmessage.plist ${WORK_D}/var/db/dslocal/nodes/MCX/computergroups/login_window_show_textfieldsmessage.plist
