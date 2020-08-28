#!/usr/bin/env bash

# Created by: @spirillen
# Copyright: https://www.mypdns.org/
# License: My Privacy DNS (https://www.mypdns.org/wiki/License)

# Please forward any additions, corrections or comments by logging an issue at
# https://gitlab.com/my-privacy-dns/support/issues

# **********************
# Setting data variables
# **********************
source "scripts/variables.sh"

# ******************
# Database functions
# ******************

#MySqlImport
printf "\n\tSetup Local MariaDB...\n"
	sudo mariadb -u root -h localhost -e "CREATE DATABASE pyfunceble DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
	sudo mysql -u root -h localhost -e "CREATE USER 'root'@'%' IDENTIFIED BY ''"
	sudo mysql -u root -h localhost -e "CREATE USER 'pyfunceble'@'localhost' IDENTIFIED BY 'pyfunceble';"
	sudo mysql -u root -h localhost -e "GRANT ALL PRIVILEGES ON pyfunceble.* TO 'pyfunceble'@'localhost';"
	if [ -f "${HOME}/db/pyfunceble.sql" ]
	then
		mysql --user=pyfunceble --password=pyfunceble pyfunceble < "${HOME}/db/pyfunceble.sql"
	fi
printf "\nMySql Import DONE\n"

# ***************
# Import via AXFR
# ***************
printf "\nImporting AXFR\n"

AXFRImport () {
	truncate -s 0 "${SOURCE_FILE}"
	
    	drill axfr rpz.mypdns.cloud @axfr.ipv4.mypdns.cloud -p 5306 \
		| grep -F "CNAME" | grep -vE "(^(\*\.|$))" \
		| sed 's/\.rpz\.mypdns\.cloud.*$//;s/^\s*\(.*[^ \t]\)\(\s\+\)*$/\1/' \
		> "${SOURCE_FILE}"

	printf "\n\tAXFR Importing... DONE!\n"
	##exit ${?}
}
AXFRImport

#ImportRPZ () {
#	mysql -u"${imp_user}" -p"${imp_pw}" -h"${imp_host}" -B -N -e "SELECT TRIM(TRAILING '.rpz.mypdns.cloud' FROM name) AS name FROM pdns.records WHERE \`type\` = 'CNAME' AND domain_id = '36' AND content = '.' LIMIT 10000000;" > "${SOURCE_FILE}"
#}
#ImportRPZ

printf "\nWe have to test $(wc -l < "${SOURCE_FILE}") DNS records.

	You can read more about how to use this privacy enhanced
	DNS firewall, driven by Response Policy Zones at
	https://www.mypdns.org/wiki/RpzList\n"

#ImportWhiteList () {
	#printf "\nImporting whitelist\n"
	#truncate -s 0 "${whitelist}"
	#wget -qO "${whitelist}" 'https://gitlab.com/my-privacy-dns/matrix/matrix/raw/master/source/whitelist/domain.list'
	#wget -qO- 'https://gitlab.com/my-privacy-dns/matrix/matrix/raw/master/source/whitelist/wildcard.list' >> "${whitelist}"
#}
#ImportWhiteList

#WhiteListing () {
    #if [[ "$(git log -1 | tail -1 | xargs)" =~ "ci skip" ]]
        #then
			#printf "\nRunning whitelist\n"
            #hash uhb_whitelist
            #uhb_whitelist -f "${SOURCE_FILE}" -o "${SOURCE_FILE}"
	#else
		#printf "\nSkipping whitelist\n"
    #fi
#}
#WhiteListing

#exit ${?}

#bash "${script_dir}/pyfunceble.sh"

exit ${?}
