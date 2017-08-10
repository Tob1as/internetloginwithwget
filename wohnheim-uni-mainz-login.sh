#!/bin/sh
#
# This script provides login- and logout-functionality
# for the network in the Johannes-Gutenberg-University Mainz.
# 
# Dependency: wget
#

USER=           # Insert ZDV-Username here
PASSWORD=       # Insert corresponding Password here

login() {
    echo "Logging in..."
    wget --post-data "user=${USER}&pass=${PASSWORD}" --delete-after --quiet https://login.wohnheim.uni-mainz.de/cgi-bin/login-cgi
}

logout() {
    echo "Logging out..."
    wget --post-data 'command=logout' --delete-after --quiet https://login.wohnheim.uni-mainz.de/cgi-bin/logout.cgi
}

case $1 in
    reconnect) logout; login;;
    logout) logout;;
    login) login;;
    *) echo "Usage: ./wohnheim-uni-mainz-login.sh login|logout|reconnect ";;
esac
