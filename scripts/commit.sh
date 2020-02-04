#!/usr/bin/env bash

# Created by: @spirillen
# Copyright: https://www.mypdns.org/
# License: My Privacy DNS (https://www.mypdns.org/wiki/License)

# Please forward any additions, corrections or comments by logging an issue at
# https://gitlab.com/my-privacy-dns/support/issues

source "scripts/variables.sh"

printf "\n\tRunning Commit.sh\n"

if [ -f "${SCRIPT_DIR}/output/domains/INACTIVE/list" ]
then
  printf "\nExporting INACTIVE domains\n"
  grep -Ev "^($|#)" "${SCRIPT_DIR}/output/domains/INACTIVE/list" \
	> "${ROOT_DIR}/inactive_domains.txt"
else
	printf "\nNo INACTIVE domains found\n"
fi

if [ -f "${SCRIPT_DIR}/output/domains/INVALID/list" ]
then
  printf "\nExporting dead domains\n"
  grep -Ev "^($|#)" "${SCRIPT_DIR}/output/domains/INVALID/list" \
	> "${ROOT_DIR}/invalid_domains.txt"
else
	printf "\nNo INVALID domains found\n"
fi

exit ${?}
