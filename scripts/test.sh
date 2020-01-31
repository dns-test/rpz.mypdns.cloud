#!/usr/bin/env bash
# **********************
# Run PyFunceble Testing
# **********************
# Created by: @spirillen
# Copyright: My Privacy DNS (https://www.mypdns.org/wiki/License)

# ****************************************************************
# This test script uses PyFunceble by @funilrys aka Nissar Chababy
# Find PyFunceble at: https://github.com/funilrys/PyFunceble
# ****************************************************************

# **********************
# Setting date variables
# **********************
#printf "\nSetting Variables\n"
source ${TRAVIS_BUILD_DIR}/scripts/variables.sh

# ******************
# Database functions
# ******************

#MySqlImport
printf "\nMySql import...\n"
	sudo mysql -u root -h localhost -e "CREATE DATABASE pyfunceble DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
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
	truncate -s 0 "${testfile}"
	
    dig axfr rpz.mypdns.cloud @axfr.ipv4.mypdns.cloud -p 5353 \
		| grep -F "CNAME" | grep -vE "(^(\*\.|$))" \
		| sed 's/\.rpz\.mypdns\.cloud.*$//;s/^\s*\(.*[^ \t]\)\(\s\+\)*$/\1/' \
		> "${testfile}"

	printf "\nImporting AXFR... DONE!\n"
	exit ${?}
}
AXFRImport

printf "\nPrint head of test file\n"

head "${testfile}"

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
            #uhb_whitelist -f "${testfile}" -o "${testfile}"
	#else
		#printf "\nSkipping whitelist\n"
    #fi
#}
#WhiteListing

#exit ${?}

#bash "${script_dir}/pyfunceble.sh"

exit ${?}
