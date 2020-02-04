#!/usr/bin/env bash

# **********************
# Setting date variables
# **********************

# First setup the working dir
pushd . > /dev/null
SCRIPT_PATH="${BASH_SOURCE[0]}";
if ([ -h "${SCRIPT_PATH}" ]) then
  while([ -h "${SCRIPT_PATH}" ]) do cd `dirname "$SCRIPT_PATH"`; SCRIPT_PATH=`readlink "${SCRIPT_PATH}"`; done
fi
cd `dirname ${SCRIPT_PATH}.` > /dev/null
SCRIPT_PATH=`pwd`;
popd  > /dev/null

ROOT_DIR="$(dirname "$SCRIPT_PATH")"

printf "\nSetting Variables\n"
echo "export script_dir='${ROOT_DIR}/scripts'"
echo "export testdir='${ROOT_DIR}/test_data'"

testdir="${ROOT_DIR}/test_data"

testfile="rpz.mypdns.cloud.list"
echo "testfile='${testdir}/${testfile}'"

## Whitelist.... there are none
#whitelist="whitelist.txt"
#echo "whitelist='${whitelist}'"
#echo "whitelist=$('${testdir}/${whitelist}')"

echo -e "tag="$(date '+%F %T %Z %z')""

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
