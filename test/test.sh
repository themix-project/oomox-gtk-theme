#!/usr/bin/env bash

#
# (C) 2017 actionless
#

set -ueo pipefail

DEFAULT_SLEEP=${DEFAULT_SLEEP:-2}
SCREENSHOTS_DIR=${TEST_DIR}/../screenshots/
mkdir -p ${TEST_RESULT_DIR} || true
cd ${TEST_DIR}


if [[ "${TEST_HIDPI:-}" -eq 1 ]] ; then
	export GDK_SCALE=2
	export GDK_DPI_SCALE=0.5

	export GTK2_RESOLUTION="1260x1120x16"
	export GTK2_AWF_RESOLUTION="1680x1400x16"
	export GTK3_RESOLUTION="2480x1500x16"
	export FONT_SIZE="20"
else
	export GDK_SCALE=1
	export GDK_DPI_SCALE=1

	export GTK2_RESOLUTION="630x560x16"
	export GTK2_AWF_RESOLUTION="840x700x16"
	export GTK3_RESOLUTION="1240x750x16"
	export FONT_SIZE="10"
fi


TEST_EXIT_CODE=0

mkdir -p ~/.config/gtk-3.0 || true
mkdir -p ~/.config/openbox || true

sed \
	-e 's/\${THEME_NAME}/'${THEME_NAME}'/g' \
	-e 's/\${FONT_SIZE}/'${FONT_SIZE}'/g' \
	./gtk3-settings.ini.tpl > ~/.config/gtk-3.0/settings.ini
sed \
	-e 's/\${THEME_NAME}/'${THEME_NAME}'/g' \
	-e 's/\${FONT_SIZE}/'${FONT_SIZE}'/g' \
	./openbox-rc.xml.tpl > ~/.config/openbox/rc.xml
sed \
	-e 's/\${THEME_NAME}/'${THEME_NAME}'/g' \
	-e 's/\${FONT_SIZE}/'${FONT_SIZE}'/g' \
	./gtkrc-2.0.tpl > ~/.gtkrc-2.0


killall Xvfb 2>/dev/null || true
killall openbox 2>/dev/null || true
#killall lxappearance 2>/dev/null || true

_kill_procs() {
	set +e
	kill -TERM $opbx 2>/dev/null || true
	wait $opbx
	kill -TERM $xvfb 2>/dev/null || true
	wait $xvfb
}
trap _kill_procs EXIT SIGHUP SIGINT SIGTERM INT

################################################################################
start_xserver_and_wm() {
	resolution=${1}
	Xvfb :99 -ac -screen 0 $resolution -nolisten tcp &
	xvfb=$!
	echo "== Started Xvfb"
	export DISPLAY=:99
	sleep ${DEFAULT_SLEEP}
	openbox &
	opbx=$!
	echo "== Started openbox"
	sleep ${DEFAULT_SLEEP}
	xrdb -merge ./Xresources
	xsetroot -solid white
	xdotool mousemove --sync 0 0
	#sleep ${DEFAULT_SLEEP}
}

get_window_id() {
	xdotool search --pid $1 2>/dev/null | tail -n 1
}

make_and_compare_screenshot() {
	test_variant=${1}
	sleep ${DEFAULT_SLEEP}
	screenshot_base_name=theme-${THEME_NAME}-${test_variant}
	test_result_base_name=$(date +%H-%M-%S)_${screenshot_base_name}
	scrot ${TEST_RESULT_DIR}/${test_result_base_name}.test.png

	precompare_result=0
	precompare_output=$(mktemp)
	compare -verbose -metric PAE \
		${SCREENSHOTS_DIR}/${screenshot_base_name}.png \
		${TEST_RESULT_DIR}/${test_result_base_name}.test.png \
		${TEST_RESULT_DIR}/${test_result_base_name}.diff.png \
		1>${precompare_output} 2>&1 \
		|| precompare_result=$?
	if [[ ${precompare_result} -ne 0 ]] ; then
		cat ${precompare_output}
	fi
	rm ${precompare_output}

	compare_result=0
	compare_output=$(mktemp)
	compare -verbose -metric AE -fuzz 10 \
		${SCREENSHOTS_DIR}/${screenshot_base_name}.png \
		${TEST_RESULT_DIR}/${test_result_base_name}.test.png \
		${TEST_RESULT_DIR}/${test_result_base_name}.diff.png \
		1>${compare_output} 2>&1 \
		|| compare_result=$?
	if [[ ${compare_result} -eq 0 ]] ; then
		echo
		echo "!!! SUCCESS"
		rm ${TEST_RESULT_DIR}/${test_result_base_name}.test.png
		rm ${TEST_RESULT_DIR}/${test_result_base_name}.diff.png
		echo
	else
		echo
		echo "[31m[X] FAIL[30m[m"
		echo
		cat ${compare_output}
		echo

		(
			if [[ ! -z ${GENERATE_ASSETS:-} ]] ; then
				set +e
			fi
			cp ${SCREENSHOTS_DIR}/${screenshot_base_name}.png ${TEST_RESULT_DIR}/${test_result_base_name}.png || true
		)

		if [[ -z ${GENERATE_ASSETS:-} ]] ; then
			echo "${THEME_NAME} ${test_variant}:" >> ${TEST_RESULT_DIR}/links.txt
			curl --upload-file ${TEST_RESULT_DIR}/${test_result_base_name}.test.png \
				https://transfer.sh/${test_result_base_name}.test.png >> ${TEST_RESULT_DIR}/links.txt \
				&& echo >> ${TEST_RESULT_DIR}/links.txt \
				|| true
			curl --upload-file ${SCREENSHOTS_DIR}/${screenshot_base_name}.png \
				https://transfer.sh/${test_result_base_name}.orig.png >> ${TEST_RESULT_DIR}/links.txt \
				&& echo >> ${TEST_RESULT_DIR}/links.txt \
				|| true
			curl --upload-file ${TEST_RESULT_DIR}/${test_result_base_name}.diff.png \
				https://transfer.sh/${test_result_base_name}.diff.png >> ${TEST_RESULT_DIR}/links.txt \
				&& echo >> ${TEST_RESULT_DIR}/links.txt \
				|| true
			exit 1
		else
			cp ${TEST_RESULT_DIR}/${test_result_base_name}.test.png \
				${SCREENSHOTS_DIR}/${screenshot_base_name}.png
		fi
		TEST_EXIT_CODE=1
		rm ${compare_output}
	fi
}


if [[ -z ${SKIP_GTK2:-} ]] ; then
################################################################################
echo
echo "========= Going to test GTK+2 theme (awf)..."
echo

start_xserver_and_wm ${GTK2_AWF_RESOLUTION}

FAKETIME="2017-08-29 01:02:01" FAKETIME_NO_CACHE=1 LD_PRELOAD=/usr/lib/faketime/libfaketime.so.1 awf-gtk2 2>/dev/null &
echo "== Started awf-gtk2"

make_and_compare_screenshot "gtk2-awf"
_kill_procs
################################################################################
fi

if [[ -z ${SKIP_GTK3:-} ]] ; then
################################################################################
echo
echo "========= Going to test GTK+3 theme..."
echo

start_xserver_and_wm ${GTK3_RESOLUTION}

echo "== Page 1"
echo
sleep ${DEFAULT_SLEEP}
sleep ${DEFAULT_SLEEP}
FAKETIME="2017-08-29 01:02:03" FAKETIME_NO_CACHE=1 LD_PRELOAD=/usr/lib/faketime/libfaketime.so.1 gtk3-widget-factory 2>/dev/null &
gwf=$!
echo "== Started gtk3-widget-factory"
sleep ${DEFAULT_SLEEP}
sleep ${DEFAULT_SLEEP}
make_and_compare_screenshot "gtk3-page1"
kill $gwf
wait $gwf || true
echo "== Killed gtk-widget-factory"

echo "== Page 2"
echo
sleep ${DEFAULT_SLEEP}
FAKETIME="@2017-08-29 01:03:04" FAKETIME_NO_CACHE=1 LD_PRELOAD=/usr/lib/faketime/libfaketime.so.1 gtk3-widget-factory 2>/dev/null &
gwf=$!
echo "== Started gtk3-widget-factory"

sleep ${DEFAULT_SLEEP}
X=620
Y=30
if [[ "${TEST_HIDPI:-}" -eq 1 ]] ; then
	X=$((X * 2))
	Y=$((Y * 2))
fi
xdotool mousemove -w $(get_window_id $gwf) --sync $X $Y
xdotool click 1
xdotool mousemove --sync 0 0
make_and_compare_screenshot "gtk3-page2"

echo "== Page 3"
X=720
Y=30
if [[ "${TEST_HIDPI:-}" -eq 1 ]] ; then
	X=$((X * 2))
	Y=$((Y * 2))
fi
xdotool mousemove -w $(get_window_id $gwf) --sync $X $Y
xdotool click 1
xdotool mousemove --sync 0 0
make_and_compare_screenshot "gtk3-page3"
################################################################################
fi

exit ${TEST_EXIT_CODE}
