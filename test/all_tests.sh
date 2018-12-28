#!/usr/bin/env bash

#
# (C) 2017 actionless
#

set -ueo pipefail
TEST_DIR=$(readlink -e "$(dirname "${0}")")
export TEST_DIR
SCRIPT_DIR=$(readlink -e "${TEST_DIR}"/..)
TEST_RESULT_DIR=${SCRIPT_DIR}/test_results/$(date +%Y-%m-%d_%H-%M-%S)
export TEST_RESULT_DIR
cd "${TEST_DIR}"

#export GENERATE_ASSETS=1

MAX_RETRIES=${MAX_RETRIES:-2}
if [[ -n ${GENERATE_ASSETS:-} ]] ; then
	MAX_RETRIES=0
fi


function ctrl_c() {
	exit 3
}
trap ctrl_c INT


_kill_procs() {
	set +e
	chmod 777 "${TEST_RESULT_DIR}"/*
	links=$(cat "${TEST_RESULT_DIR}"/links.txt)
	if [[ -n "${links}" ]] ; then
		echo "[33mCaptured failures:[30m[m"
		echo "${links}"
	fi
}
trap _kill_procs EXIT SIGHUP SIGINT SIGTERM


run_theme_testsuite() {
	export retries=0
	while [[ ${retries} -le ${MAX_RETRIES} ]] ; do
		echo
		if [[ ${retries} -gt 0 ]] ; then
			echo "[33m======== RE-TRYING ${retries} of ${MAX_RETRIES}...[30m[m"
		else
			echo "==============================================================="
			echo "       Going to test '${THEME_NAME}'...                        "
			echo "==============================================================="
		fi
		if ./test.sh ; then
			break
		fi
		export retries=$((retries+1))
	done
	if [[ ${retries} -le ${MAX_RETRIES} ]] ; then
		echo "[32m==============================================================="
		echo "[32m      Testsuite for '${THEME_NAME}' executed successfully!     "
		echo "[32m===============================================================[30m[m"
		return 0
	else
		return 1
	fi
}


if [[ ! -d ${TEST_RESULT_DIR} ]] ; then
	mkdir -p "${TEST_RESULT_DIR}"
fi
echo > "${TEST_RESULT_DIR}"/links.txt

_TEST_THEMES=(
	'clearlooks'
	'lavender'
	'monovedek_lcars'
)
TEST_THEMES=${TEST_THEMES-${_TEST_THEMES[@]}}

if [[ ${TESTSUITE_LODPI:-1} = 1 ]] ; then
	echo "${TEST_THEMES[@]}" | parallel --will-cite --delimiter ' ' --colsep '%' \
		bash /opt/oomox-gtk-theme/change_color.sh /opt/oomox-gtk-theme/test/colors/{} 2>&1
fi
if [[ ${TESTSUITE_HIDPI:-1} = 1 ]] ; then
	echo "${TEST_THEMES[@]}" | parallel --will-cite --delimiter ' ' --colsep '%' \
		bash /opt/oomox-gtk-theme/change_color.sh /opt/oomox-gtk-theme/test/colors/{} -o oomox-{}_hidpi --hidpi True 2>&1
fi

if [[ -n ${GENERATE_ASSETS:-} ]] ; then
	set +e
fi

for theme in "${TEST_THEMES[@]}" ; do


	if [[ ${TESTSUITE_LODPI:-1} = 1 ]] ; then
		export TEST_HIDPI=0
		export THEME_NAME=${theme}
		run_theme_testsuite
	fi

	if [[ ${TESTSUITE_HIDPI:-1} = 1 ]] ; then
		export TEST_HIDPI=1
		export THEME_NAME="${theme}_hidpi"
		run_theme_testsuite
	fi

done

exit 0
