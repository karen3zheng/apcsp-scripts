#!/bin/bash

NUM=1
IPADDR=10.120.0.$NUM
PORTS="22 80"

for i in {1..255} ; do
	NUM=$i
	IPADDR=10.120.0.$NUM
	timeout 0.1 ping -c 1 $IPADDR &> /dev/null
	if [ $? -eq 0 ] ; then
		echo $IPADDR": alive"
		echo "hostname:" $(getent hosts $IPADDR | awk '{print $2}')
		echo "ip address:" $IPADDR

		MCADDR=$(grep $IPADDR /proc/net/arp | awk '{print $4}')
		if [ -z "$MCADDR" ] ; then
			MCADDR=$(ip link | grep link/ether | awk 'FNR == 2 {print $2}')
		fi
		echo "mac address:" $MCADDR

		echo -n "open ports: "
		for PORT in $PORTS ; do
			timeout 0.1 nc -zv -w 1 $IPADDR $PORT &> /dev/null
			if [ $? -eq 0 ] ; then
				echo -n $PORT
			fi
		done

		echo
		echo
	fi
done

