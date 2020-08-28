#!/usr/bin/env bash

# https://www.mypdns.org/P12
# Copyright: https://www.mypdns.org/
# Content: https://www.mypdns.org/p/Spirillen/
# Source: https://github.com/Import-External-Sources/pornhosts
# License: https://www.mypdns.org/w/license
# License Comment: GNU AGPLv3, MODIFIED FOR NON COMMERCIAL USE
#
# License in short:
# You are free to copy and distribute this file for non-commercial uses,
# as long the original URL and attribution is included.
#
# Please forward any additions, corrections or comments by logging an
# issue at https://www.mypdns.org/maniphest/

set -e

# Set the repos main dir
git_dir="$(git rev-parse --show-toplevel)"

rec_dir="/etc/powerdns" # No trailing slash

# Setup PowerDNS repos to use master releases for testing.
printf "deb [arch=amd64] http://repo.powerdns.com/ubuntu %s-rec-master main\n" \
  "$(lsb_release -cs)" > "/etc/apt/sources.list.d/pdns.list"

printf "Package: pdns-*\nPin: origin repo.powerdns.com\nPin-Priority: 600" > \
  "/etc/apt/preferences.d/pdns"

curl "https://repo.powerdns.com/CBC8B383-pub.asc" | sudo apt-key add - && \
  sudo apt-get update -q && \
  sudo apt-get install -q pdns-recursor ldnsutils

# Lets get rit of known deadbeats by loading the Response policy zone
# for known pirated domains

rm -f "${rec_dir}/recursor.conf"
wget -qO "${rec_dir}/recursor.conf" \
  'https://raw.githubusercontent.com/DNS-RPZ/scripts/master/recursor/recursor.conf'

rm -f "${rec_dir}/recursor.lua"
wget -qO "${rec_dir}/recursor.lua" \
  'https://raw.githubusercontent.com/DNS-RPZ/scripts/master/recursor/recursor.lua'

# Change uid & gid to ensure the right permissions
chown root:pdns "${rec_dir}/recursor.conf"
chown root:root "${rec_dir}/recursor.lua"

# Set filepermission on recursor.conf
chmod 640 "${rec_dir}/recursor.conf"

systemctl restart pdns-recursor.service

# Allow the PowerDNS Recursor to load the RPZ zone
# before testing it
sleep 5

# Check if the recursor is listening to port on port 5300
if lsof -i :5300 | grep -q '^pdns_'
then
	printf "\n\tThe recursor is running on port 5300
	We carry on with our test procedure\n"
else
	printf "\n\tRecursor not running, We stops here\n"
	exit 1
fi

if drill 21x.org @127.0.0.1 -p 5300 | grep -qi "NXDOMAIN"
then
	printf "\n\tPirated domains Response policy zone from\n\tMy Privacy DNS is loaded... Good\n\n"
else
	printf "\t\nResponse policy zone not loaded, we are done for this time\n\n"
	exit 1
fi

exit ${?}


# This program is free software: you can redistribute it and/or modify
# it under the terms of the modified GNU Affero General Public License as
# published by the My Privacy DNS, either version 3 of the
# License, or any later version released at
# https://www.mypdns.org/w/License.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# modified GNU Affero General Public License for more details.

# You should have received a copy of the modified GNU Affero General Public License
# along with this program. If not, see https://www.mypdns.org/w/License.

# The modification: The standard AGPLv3 have been altered to NOT allow
# any to generate profit from our work. You are however free to use it to any
# NON PROFIT purpose. If you would like to use any of our code for profiteering
# YOU are obliged to contact https://www.mypdns.org/ for profit sharing.
