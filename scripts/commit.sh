#!/usr/bin/env bash
# https://www.mypdns.org/
# Copyright: Content: https://gitlab.com/spirillen

# You are free to copy and distribute this file for non-commercial uses,
# as long the original URL and attribution is included.

# Please forward any additions, corrections or comments by logging an issue at
# https://gitlab.com/my-privacy-dns/support/issues

#source ${TRAVIS_BUILD_DIR}/scripts/variables.sh

printf "\n\tRunning Commit.sh\n"

if [ -f "${script_dir}/output/domains/INACTIVE/list" ]
then
  printf "\nExporting dead domains\n"
  grep -Ev "^($|#)" "${script_dir}/output/domains/INACTIVE/list" \
	> "${TRAVIS_BUILD_DIR}/inactive_domains.txt"
else
	printf "\nNo dead domains found\n"
fi

cat "${HOME}/db/pyfunceble.sql"

exit ${?}
