#!/bin/bash
#
# This script provides login- and logout-functionality
# for the dormitory network of the Johannes-Gutenberg-University Mainz
# and Studierendenwerk Mainz.
# 
# Dependency: wget
#

#ZDV_USERNAME=		# Insert ZDV-Username here
#ZDV_PASSWORD=		# Insert corresponding Password here

source ./login_config.cfg

login() {
	echo "Logging in..."
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
