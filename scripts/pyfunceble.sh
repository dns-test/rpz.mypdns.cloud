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
source "scripts/variables.sh"

printf "\nLists SOURCE_FILE\n"
ls -lha "${SOURCE_FILE}"

printf "\nHead SOURCE_FILE\n"
head "${SOURCE_FILE}"

# **********************
# Run PyFunceble Testing
# **********************

printf "\nRunning PyFunceble\n"

RunPyFunceble () {

    #tag=$(date '+%F %X %Z %z')

    cd "${script_dir}"

    hash PyFunceble

    if [[ -f "${script_dir/.PyFunceble.yaml}" ]]
    then
        rm "${script_dir}/.PyFunceble.yaml"
        rm "${script_dir}/.PyFunceble_production.yaml"
    fi

    PyFunceble --version
    PyFunceble --ci -q -ex --plain --idna -db -h --http \
	--database-type mariadb -m -p $(nproc --ignore=1) \
        --hierarchical \
        --autosave-minutes 35 \
        --ci-branch master \
        --ci-distribution-branch master \
	--cmd-before-end "bash ${TRAVIS_BUILD_DIR}/scripts/commit.sh" \
        --commit-autosave-message "${tag}.${TRAVIS_BUILD_NUMBER} [Auto Saved]" \
        --commit-results-message "${tag}.${TRAVIS_BUILD_NUMBER}" \
         -f "${SOURCE_FILE}"
}

RunPyFunceble

exit ${?}
