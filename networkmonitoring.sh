#!/bin/bash
# 
# This script checks the online connection every $waittime seconds
# with a ping to $HOSTS and attempts to re-login if ping fails
#
# Dependency: login.sh
#



waittime=30                     # insert time to wait between checks here
countpings=4					# insert the number of ping attempts

HOSTS='134.93.178.2 google.de'	#uni-mainz.de&google.d	# add ip / hostname separated by white space



while true; do
	echo "Check start at $(date)"
	
	let COUNTER=0 
	let ERROR=0 
	
	for HOST in $HOSTS
	do
		# check packet loss in %
		pingvalue=$(ping -qc $countpings $HOST | grep -oP '\d+(?=% packet loss)')
		if [ $pingvalue -ge 50 ]; then
			echo "Host : $HOST is not available (ping failed) at $(date)"
			let ERROR=ERROR+1
		fi
		let COUNTER=COUNTER+1
	done
	
	# login again, when more then 50% pings to hosts failed
	#let ERROR_Percent=$((200*$ERROR/$COUNTER % 2 + 100*$ERROR/$COUNTER))
	let ERROR_Percent=$((100*$ERROR/$COUNTER))
	printf "%.2f%% ping lost\n" $ERROR_Percent
	if [ $ERROR_Percent -gt 50 ]; then
		echo "Logging in... at $(date)"
		./login_wohnheim_uni_mainz_de.sh login > /dev/null
		continue
	fi
	
    sleep $waittime
	
done;
