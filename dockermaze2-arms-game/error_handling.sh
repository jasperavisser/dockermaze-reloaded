#!/bin/bash

function logError {
    local line="$1"
    echo "Error occurred on line ${line} in ${0}"
}

function enableErrorTrap {
    set -o errtrace
    set -o pipefail
    trap 'EXIT_CODE=$?; logError ${LINENO}; [ -z ${EXIT_CODE+x} ] || exit ${EXIT_CODE};' ERR
}

function disableErrorTrap {
    trap - ERR
    set +o errtrace
    set +o pipefail
}

enableErrorTrap
