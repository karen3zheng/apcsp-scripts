#!/bin/bash

# list of droplets, dl11 does not exist and should be dead
DROPLETS="dl01 dl02 dl03 dl04 dl05 dl06 dl07 dl08 dl09 dl10 dl11"
# list of droplets to check
CHECK=$DROPLETS

# if there are one or more args, only check the droplets specified
if [ $# -gt 0 ] ; then
	CHECK="$*"
fi

# check if each droplet is alive
for i in $CHECK ; do
	ping -c 1 $i &> /dev/null # pings each droplet once and redirects output so it doesn't show
	if [ $? -eq 0 ] ; then # if the ping was successful, it is alive
		echo $i ": alive"
	else # if the ping was not successful, it is dead
		echo $i ": dead"
	fi
done

exit 0
