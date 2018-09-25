#!/usr/bin/env bash
#compare $2 $1 png:- | montage -geometry +4+4 $2 - $1 png:- | display -title "$1" -

temp=$(mktemp --suffix .png)
compare $2 $1 png:- | montage -geometry +4+4 $2 - $1 png:- > ${temp}
#sxiv -N "$1" ${temp}
viewnior ${temp}
rm ${temp}
