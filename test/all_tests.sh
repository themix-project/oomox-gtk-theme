#!/usr/bin/env bash

#
# (C) 2017 actionless
#

set -ueo pipefail
export TEST_DIR=$(readlink -e $(dirname "${0}"))
export TEST_RESULT_DIR=${TEST_DIR}/../test_results/$(date +%Y-%m-%d_%H-%M-%S)
cd ${TEST_DIR}

#export GENERATE_ASSETS=1

MAX_RETRIES=${MAX_RETRIES:-2}
if [[ ! -z ${GENERATE_ASSETS:-} ]] ; then
	MAX_RETRIES=0
fi


function ctrl_c() {
	exit 3
}
trap ctrl_c INT


_kill_procs() {
	set +e
	chmod 777 ${TEST_RESULT_DIR}/*
	cat ${TEST_RESULT_DIR}/links.txt
}
trap _kill_procs EXIT SIGHUP SIGINT SIGTERM


run_theme_testsuite() {
	export retries=0
	while [[ ${retries} -le ${MAX_RETRIES} ]] ; do
		if [[ ${retries} -gt 0 ]] ; then
			echo "======== RE-TRYING ${retries} of ${MAX_RETRIES}..."
		fi
		./test.sh && break || true
		export retries=$[$retries+1]
	done
	if [[ ${retries} -le ${MAX_RETRIES} ]] ; then
		echo "==============================================================="
		echo "      Testsuite for '${THEME_NAME}' executed successfully!     "
		echo "==============================================================="
		return 0
	else
		return 1
	fi
}


if [[ ! -d ${TEST_RESULT_DIR} ]] ; then
	mkdir -p ${TEST_RESULT_DIR}
fi
echo > ${TEST_RESULT_DIR}/links.txt

echo "monovedek
monovedek_hidpi
clearlooks
clearlooks_hidpi" | parallel bash /opt/oomox-gtk-theme/change_color.sh /opt/oomox-gtk-theme/test/colors/{}  2>&1

if [[ ! -z ${GENERATE_ASSETS:-} ]] ; then
	set +e
fi

export TEST_HIDPI=0
export THEME_NAME="clearlooks"
run_theme_testsuite

export TEST_HIDPI=1
export THEME_NAME="clearlooks_hidpi"
run_theme_testsuite

export TEST_HIDPI=0
export THEME_NAME="monovedek"
run_theme_testsuite

export TEST_HIDPI=1
export THEME_NAME="monovedek_hidpi"
run_theme_testsuite

exit 0
