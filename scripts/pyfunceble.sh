#!/usr/bin/env bash
# **********************
# Run PyFunceble Testing
# **********************
# Created by: @spirillen
# Copyright: https://www.mypdns.org/
# License: My Privacy DNS (https://www.mypdns.org/wiki/License)

# ****************************************************************
# This test script uses PyFunceble by @funilrys aka Nissar Chababy
# Find PyFunceble at: https://github.com/funilrys/PyFunceble
# ****************************************************************

# **********************
# Setting date variables
# **********************
source "scripts/variables.sh"

# **********************
# Run PyFunceble Testing
# **********************

printf "\nRunning PyFunceble\n"

RunPyFunceble () {

    cd "${SCRIPT_DIR}"

    hash PyFunceble

    if [[ -f "${SCRIPT_DIR/.PyFunceble.yaml}" ]]
    then
        rm "${SCRIPT_DIR}/.PyFunceble.yaml"
        rm "${SCRIPT_DIR}/.PyFunceble_production.yaml"
    fi

    if [[ -f "${SCRIPT_DIR/.PyFunceble-env}" ]]
    then
    	mv "${SCRIPT_DIR/.PyFunceble-env}" "${SCRIPT_DIR/.PyFunceble-env.bak}"
    fi

    PyFunceble --version
    
    echo ""
    
    PyFunceble --ci -q -ex --plain --idna -db -h --http \
	--database-type mariadb -m --hierarchical \
        --dns 127.0.0.1:5300 --autosave-minutes 2 \
        --ci-branch master \
        --ci-distribution-branch master \
	--cmd-before-end "bash ${SCRIPT_DIR}/commit.sh" \
        --commit-autosave-message "${tag}.${BUILD_ID} [Auto Saved]" \
        --commit-results-message "${tag}.${BUILD_ID}" \
         -f "${SOURCE_FILE}"
}

RunPyFunceble

exit ${?}

#  -p $(nproc --ignore=1)
