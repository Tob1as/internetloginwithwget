#!/bin/bash
# 
# This script checks the online connection every $waittime seconds
# with a ping to $targetpingdevice and attempts to re-login if 
# ping fails
#
# Dependency: login.sh
#


waittime=30                     # insert time to wait between checks here
countpings=4					# insert the number of ping attempts

HOSTS='134.93.178.2 google.de'	#uni-mainz.de&google.d	# add ip / hostname separated by white space

let COUNTER=0 # Do NOT edit!
let ERROR=0 # Do NOT edit!

while true; do
	echo "Check start at $(date)"
	for HOST in $HOSTS
	do
		#sleep 5
		# check packet loss in %
		pingvalue=$(ping -qc $countpings $HOST | grep -oP '\d+(?=% packet loss)')
		if [ $pingvalue -ge 50 ]; then
			echo "Host : $HOST is not available (ping failed) at $(date)"
			let ERROR=ERROR+1
		fi
		let COUNTER=COUNTER+1
	done
	# login again, when more then 50% pings to hosts failed
	if [ $COUNTER -eq $ERROR ]; then
		echo "Logging in... at $(date)"
		./login_wohnheim_uni_mainz_de.sh login > /dev/null
		continue
	fi
	let COUNTER=0
	let ERROR=0
    sleep $waittime
done;

# Alternative (with one host):
#targetpingdevice=134.93.178.2   #uni-mainz.de   # insert IP or hostname for ping target
#
#while true; do
#	echo "Check start at $(date)"
#	# check ping received
#	#pingvalue=$(ping -qc $countpings $targetpingdevice | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
#	#pingvalue=$(ping -qc $countpings $targetpingdevice | grep -oP '\d+(?= received)')
#	# check packet loss in %
#	pingvalue=$(ping -qc $countpings $targetpingdevice | grep -oP '\d+(?=% packet loss)')
#	if [ $pingvalue -ge 50 ]; then
#		echo "Host : $targetpingdevice is not available (ping failed) at $(date)"
#		# login again
#		echo "Logging in... at $(date)"
#       ./login_wohnheim_uni_mainz_de.sh login > /dev/null
#		continue
#	fi
#   sleep $waittime
#done;
