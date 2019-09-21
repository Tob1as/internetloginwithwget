#!/bin/bash
#
# This script provides login- and logout-functionality
# for the dormitory network of the Johannes-Gutenberg-University Mainz
# and Studierendenwerk Mainz.
# 
# Dependency: wget
#

account() {
	configfile='./login_config.cfg'
	
	if [ -f $configfile -a -r $configfile ]; then
		source $configfile
	else
		# Fill out the following two lines if you don't want to use a configuration file or a user query.
		ZDV_USERNAME='myuser'
		ZDV_PASSWORD='mypassword'
	fi
	
	if [ -z "$ZDV_USERNAME" -o -z "$ZDV_PASSWORD" -o "$ZDV_USERNAME" == 'myuser' -o "$ZDV_PASSWORD" == 'mypassword' ]; then
		read -p "Username: " ZDV_USERNAME
		read -sp "Password: " ZDV_PASSWORD
	fi
	
	# only for debug!
	#echo "Username: $ZDV_USERNAME ; Password: $ZDV_PASSWORD"
}

login() {
	account
	echo -e "\nLogging in..."
	wget --post-data "user=$ZDV_USERNAME&pass=$ZDV_PASSWORD" --delete-after --quiet https://login.wohnheim.uni-mainz.de/cgi-bin/login-cgi
}

logout() {
	echo "Logging out..."
	wget --post-data 'command=logout' --delete-after --quiet https://login.wohnheim.uni-mainz.de/cgi-bin/logout.cgi
}

case $1 in
    reconnect) logout; login;;
    logout) logout;;
    login) login;;
    *) echo 'Usage: ./login_wohnheim_uni_mainz_de.sh login|logout|reconnect';;
esac
