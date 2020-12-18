#!/bin/bash

if [ $# -gt 0 ] ; then
	for i in $* ; do
		ping -c 1 $i &> /dev/null
		if [ $? -eq 0 ] ; then
			echo $i ": alive"
		else 
			echo $i ": dead"
		fi
	done
else 
	for i in dl01 dl02 dl03 dl04 dl05 dl06 dl07 dl08 dl09 dl10 dl11 ; do
		ping -c 1 $i &> /dev/null
		if [ $? -eq 0 ] ; then
			echo $i ": alive"
		else
			echo $i ": dead"
		fi
	done
fi

exit 0

