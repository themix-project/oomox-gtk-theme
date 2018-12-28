#!/bin/sh
cd "$(readlink -e "$(dirname "${0}")")"/.. &&
exec docker image build ./ -t oomox-gtk-theme
