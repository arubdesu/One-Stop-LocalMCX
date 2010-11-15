#!/bin/sh
# original here: http://managingosx.wordpress.com/2010/03/12/yet-again-with-the-local-mcx/
# first make sure /Local/MCX node exists
if [ ! -d "/private/var/db/dslocal/nodes/MCX" ] ; then
	echo "Missing /Local/MCX node!"
	exit 0
fi

# now test if /Local/MCX is already in the search path, after /Local/Default and /BSD/local
localMCXinSearchPath=`/usr/bin/dscl /Search read / CSPSearchPath | /usr/bin/grep "/Local/MCX"`
if [ "$localMCXinSearchPath" == "" ] ; then
# NOTE: the following may fail if Active Directory is last in the search path, since there's a space in the name.  I'm currently working on a permanent solution.
  currentSearchPathContainsBSDlocal=`/usr/bin/dscl /Search read / CSPSearchPath | /usr/bin/grep "/BSD/local"`
  if [ "$currentSearchPathContainsBSDlocal" != "" ] ; then
      currentSearchPathBegin="/Local/Default /BSD/local"
      currentSearchPathEnd=`/usr/bin/dscl /Search read / CSPSearchPath | /usr/bin/cut -d" " -f4-`
  else
      currentSearchPathBegin="/Local/Default"
      currentSearchPathEnd=`/usr/bin/dscl /Search read / CSPSearchPath | /usr/bin/cut -d" " -f3-`
  fi
      /usr/bin/dscl /Search create / SearchPolicy CSPSearchPath
      /usr/bin/dscl /Search create / CSPSearchPath $currentSearchPathBegin /Local/MCX $currentSearchPathEnd

# unload so we only run once
/bin/launchctl unload /Library/LaunchDaemons/com.afp548.LocalMCX-fixSearchPath.plist

fi

exit 0