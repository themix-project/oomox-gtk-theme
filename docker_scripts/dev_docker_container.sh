#!/bin/bash
cd $(readlink -e $(dirname "${0}"))/..
exec docker \
	container run \
	--detach --tty \
	--volume $(readlink -e ./):/opt/oomox-gtk-theme \
	$@ \
	oomox-gtk-theme:latest
