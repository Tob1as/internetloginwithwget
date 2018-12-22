# internetloginwithwget
Internet-Login/Logout for Linux with wget for dormitory network of the Johannes-Gutenberg-University Mainz and Studierendenwerk Mainz.

* login_config.cfg - configuration file
* login_wohnheim_uni_mainz_de.sh - Login and Logout script!
* networkmonitoring.sh - checked if the device is logged in. If not, it will be logged in with the login script.

Use:
* ``` git clone https://github.com/Tob1as/internetloginwithwget.git internetlogin && cd ./internetlogin/ && chmod +x *.sh && chmod 600 login_config.cfg ```
* Edit ``` login_config.cfg ``` - File and enter your credentials (username and password).
* Login
	* manually: ``` ./login_wohnheim_uni_mainz_de.sh login ``` 
	* automatically, when not logged in: ``` ./networkmonitoring.sh ```  (for crontab: ``` @reboot /path/to/folder/internetlogin/networkmonitoring.sh ```)

Note:
* This script is successful tested with *Debian 9 Skretch*.
* if _source_ not found then write your credentials directly in the login_wohnheim_uni_mainz_de.sh.
* if _bash_ not found then write sh instead of bash in head of *.sh files.
* if _/bin/bash^M: bad interpreter_ ``` sed -i -e 's/\r$//' *.* ```
* other Mirror: [GitLab.RLP.net](https://gitlab.rlp.net/stwmz-nags/internetloginwithwget)
* on Windows install [Cygwin](https://cygwin.com/) to use or use Powershell-Version for Windows: [Click](https://github.com/Tob1as/PowerShellScripts/tree/master/internetloginwithpowershell)
