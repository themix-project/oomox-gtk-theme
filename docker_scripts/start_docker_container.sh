#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

cd "$(readlink -e "$(dirname "${0}")")"/..
exec docker \
	container run \
	--detach --tty \
	--volume "$(readlink -e ./test_results/)":/opt/oomox-gtk-theme/test_results \
	--volume "$(readlink -e ./test/)":/opt/oomox-gtk-theme/test \
	--volume "$(readlink -e ./screenshots/)":/opt/oomox-gtk-theme/screenshots \
	"$@" \
	oomox-gtk-theme:latest
