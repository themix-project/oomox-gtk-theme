#!/usr/bin/env bash
set -ueo pipefail
cd "$(readlink -e "$(dirname "${0}")")"/..

if xhost | grep -q enabled ; then
	echo "!!! WARNING !!!"
	echo "X server access control will be disabled,"
	echo "clients will be able to connect to X server from any host"
	echo "---------------"
	echo "Do you want to proceed? [y/n]"
	read -r answer
	test "${answer}" != 'y' && exit 1
	xhost +
	# shellcheck disable=SC2329
	_exit() {
		# shellcheck disable=SC2317
		xhost -
	}
	trap _exit EXIT SIGHUP SIGINT SIGTERM INT
fi

docker run -ti \
	--rm \
	-e DISPLAY \
	-e GDK_SCALE \
	-e GDK_DPI_SCALE \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v "$HOME"/.themes:/root/.themes \
	-v "$HOME"/.config/fontconfig:/root/.config/fontconfig \
	-v /usr/share/fonts:/usr/share/fonts \
	oomox-gtk-theme:latest

exit 0
