#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


temp=$(mktemp --suffix .png)
compare "$2" "$1" png:- | montage -geometry +4+4 "$2" - "$1" png:- > "${temp}"
#sxiv -N "$1" "${temp}"
viewnior "${temp}"
rm "${temp}"
