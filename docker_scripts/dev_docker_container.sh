#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

LOCAL_TEST_RESULTS_DIR=./test_results/

mkdir -p "$LOCAL_TEST_RESULTS_DIR"

cd "$(readlink -e "$(dirname "${0}")")"/..
mkdir -p ./test_results/
exec docker \
	container run \
	--detach --tty \
	--volume "$(readlink -e ./)":/opt/oomox-gtk-theme \
	--volume "$(readlink -e "$LOCAL_TEST_RESULTS_DIR")":/opt/oomox-gtk-theme/test_results \
	"$@" \
	oomox-gtk-theme:latest
