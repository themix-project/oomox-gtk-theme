#!/bin/sh
set -ueo pipefail
TEST_DIR=$(readlink -e $(dirname "${0}"))
TEST_RESULT_DIR=${TEST_DIR}/../test_results/
cd ${TEST_DIR}

#export GENERATE_ASSETS=1

MAX_RETRIES=2
if [[ ! -z ${GENERATE_ASSETS:-} ]] ; then
	MAX_RETRIES=0
fi


function ctrl_c() {
	exit 3
}
trap ctrl_c INT


run_theme_testsuite() {
	retries=0
	while [[ ${retries} -le ${MAX_RETRIES} ]] ; do
		if [[ ${retries} -gt 0 ]] ; then
			echo "======== RE-TRYING ${retries} of ${MAX_RETRIES}..."
		fi
		./test.sh && break || true
		retries=$[$retries+1]
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

chmod 777 ${TEST_RESULT_DIR}/* || true
cat ${TEST_RESULT_DIR}/links.txt || true

exit 0
