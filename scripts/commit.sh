#!/usr/bin/env bash
# https://www.mypdns.org/
# Copyright: Content: https://gitlab.com/spirillen

# You are free to copy and distribute this file for non-commercial uses,
# as long the original URL and attribution is included.

# Please forward any additions, corrections or comments by logging an issue at
# https://gitlab.com/my-privacy-dns/support/issues

source "scripts/variables.sh"

printf "\n\tRunning Commit.sh\n"

if [ -f "${script_dir}/output/domains/INACTIVE/list" ]
then
  printf "\nExporting dead domains\n"
  grep -Ev "^($|#)" "${script_dir}/output/domains/INACTIVE/list" \
	> "${TRAVIS_BUILD_DIR}/inactive_domains.txt"
else
	printf "\nNo INACTIVE domains found\n"
fi

if [ -f "${script_dir}/output/domains/INVALID/list" ]
then
  printf "\nExporting dead domains\n"
  grep -Ev "^($|#)" "${script_dir}/output/domains/INVALID/list" \
	> "${TRAVIS_BUILD_DIR}/inactive_domains.txt"
else
	printf "\nNo INVALID domains found\n"
fi

exit ${?}
