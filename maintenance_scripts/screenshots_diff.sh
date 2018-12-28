#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

git -c diff.external="$(readlink -e maintenance_scripts/git-imgdiff.sh)" diff screenshots/
