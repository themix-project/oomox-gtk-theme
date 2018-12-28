#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

TEST_DIR=$(readlink -e "$(dirname "${0}")")
SCRIPT_DIR="$(readlink -e "${TEST_DIR}"/..)"


#hellcheck "$(find "${SCRIPT_DIR}" -name '*.sh')"
cd "${SCRIPT_DIR}"
# shellcheck disable=SC2046
shellcheck -x ./change_color.sh ./scripts/*.sh ./maintenance_scripts/*.sh ./test/*.sh $(find ./src/ -name '*.sh')

echo '$$ shellcheck passed $$'
exit 0
