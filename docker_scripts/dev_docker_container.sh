#!/bin/bash
cd $(readlink -e $(dirname "${0}"))/..
exec docker \
	container run \
	--detach --tty \
	--volume $(readlink -e ./):/opt/oomox-gtk-theme \
	--volume $(readlink -e ./test_results/):/opt/oomox-gtk-theme/test_results \
	$@ \
	oomox-gtk-theme:latest
