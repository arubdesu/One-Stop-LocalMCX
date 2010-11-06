#!/bin/sh
# original here: http://managingosx.wordpress.com/2008/02/07/mcx-dslocal-and-leopard/
# This script detects changes in the MAC address of the computer it runs on and modifies the computer record in MCX accordingly
# Additionally, if MCX management varies between laptops and desktops, it only updates the applicable record and removes the other 
changedMCX=false
# check what the currently-running computers MAC address is
macAddress=`/sbin/ifconfig en0 | /usr/bin/grep 'ether' | /usr/bin/sed "s/^[[:space:]]ether //"  | cut -f1 -d " "`
# identify if we're on a laptop, since it would therefore have "Book" in its model name
IS_LAPTOP=`/usr/sbin/system_profiler SPHardwareDataType | grep "Model Identifier" | grep "Book"`

if [ "$IS_LAPTOP" != "" ]; then
	computerRecordName=local_laptop
	otherRecordName=local_desktop
else
	computerRecordName=local_desktop
  otherRecordName=local_laptop
fi
# check what MAC address is currently stored in the computer record name
storedMacAddress=`/usr/bin/dscl /var/db/dslocal/nodes/MCX -read /Computers/$computerRecordName ENetAddress | cut -f2 -d " "`

if [ "$storedMacAddress" != "$macAddress" ] ; then
	echo "Updating MAC address for /Computers/$computerRecordName..."

	echo "was: $storedMacAddress"
	echo "now: $macAddress"
# shove in the right value for the right computer record
	/usr/bin/dscl /Local/MCX -create /Computers/$computerRecordName ENetAddress $macAddress
# prune the unused one
	/usr/bin/dscl /Local/MCX -delete /Computers/$otherRecordName ENetAddress

	changedMCX=true
fi

if [ "$changedMCX" = "true" ] ; then
	currentuser=`/usr/bin/who | grep console`

	if [ "$currentuser" = "" ]; then
		echo "Restarting loginwindow..."
		`/usr/bin/killall loginwindow`
	fi
fi

# unload so we only run once, but pieces are still present if en0 changes
/bin/launchctl unload /Library/LaunchDaemons/com.afp548.localMCX-fixMACaddy.plist

exit 0