#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


cd "$(readlink -e "$(dirname "${0}")")"/..
container_name=$(docker container ls --quiet --filter ancestor=oomox-gtk-theme:latest)
if [[ -z ${container_name} ]] ; then
	echo "Container is not running"
	exit 1
fi
exec docker container kill \
	"$@" \
	"${container_name}"
