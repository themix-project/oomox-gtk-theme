#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

TEST_DIR=$(readlink -e "$(dirname "${0}")")
SCRIPT_DIR="$(readlink -e "${TEST_DIR}"/..)"


cd "${SCRIPT_DIR}"
#hellcheck "$(find "${SCRIPT_DIR}" -name '*.sh')"
shellcheck -x scripts/*.sh ./change_color.sh
