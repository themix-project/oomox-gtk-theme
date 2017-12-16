#!/usr/bin/env bash

# To generate new screenshots:
# ${0} -e GENERATE_ASSETS=1

cd $(readlink -e $(dirname "${0}"))/..
container_name=$(docker container ls --quiet --filter ancestor=oomox-gtk-theme:latest)
if [[ -z ${container_name} ]] ; then
	echo "Container is not running"
	exit 1
fi
exec docker container exec --interactive --tty \
	$@ \
	${container_name} \
	./test/all_tests.sh
