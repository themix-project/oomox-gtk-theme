#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

LOCAL_TEST_RESULTS_DIR=./test_results/

mkdir -p "$LOCAL_TEST_RESULTS_DIR"

cd "$(readlink -e "$(dirname "${0}")")"/..
exec docker \
	container run \
	--detach --tty \
	--volume "$(readlink -e "$LOCAL_TEST_RESULTS_DIR")":/opt/oomox-gtk-theme/test_results \
	--volume "$(readlink -e ./test/)":/opt/oomox-gtk-theme/test \
	--volume "$(readlink -e ./screenshots/)":/opt/oomox-gtk-theme/screenshots \
	"$@" \
	oomox-gtk-theme:latest
