#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

set -x
git -C screenshots/ -c diff.external="$(readlink -e maintenance_scripts/git-imgdiff.sh)" diff
