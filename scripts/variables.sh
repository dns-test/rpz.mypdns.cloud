#!/usr/bin/env bash

# **********************
# Setting date variables
# **********************

TEST_FILE="rpz.mypdns.cloud.list"

testfile="${testdir}/${TEST_FILE}"

#ls -lha "${ROOT_DIR}"

#ls -lha "${testfile}"

## Whitelist.... there are none
#whitelist="whitelist.txt"
#echo "whitelist='${whitelist}'"
#echo "whitelist=$('${testdir}/${whitelist}')"

tag="$(date '+%F %T %Z %z')"

#MySqlImport () {
#	printf "\nMySql import...\n"
#	sudo mysql -u root -h localhost -e "CREATE DATABASE pyfunceble DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
#	sudo mysql -u root -h localhost -e "CREATE USER 'root'@'%' IDENTIFIED BY ''"
#	sudo mysql -u root -h localhost -e "CREATE USER 'pyfunceble'@'localhost' IDENTIFIED BY 'pyfunceble';"
#	sudo mysql -u root -h localhost -e "GRANT ALL PRIVILEGES ON pyfunceble.* TO 'pyfunceble'@'localhost';"
#	if [ -f "${HOME}/db/pyfunceble.sql" ]
#	then
#		mysql --user=pyfunceble --password=pyfunceble pyfunceble < "${HOME}/db/pyfunceble.sql"
#	fi
#	
#	printf "\nMySql Import DONE!\n"
#
#	exit ${?}
#}

#MySqlExport () {
#	printf "\nMysql Export...\n"
#	if [ ! -d "${HOME}/db/" ]
#	then
#		sudo mkdir -p "${HOME}/db/"
#	fi
#	mysqldump --user=pyfunceble --password=pyfunceble --opt pyfunceble > "${HOME}/db/pyfunceble.sql"
#	printf "\nMySql Export done...\n"
#}
