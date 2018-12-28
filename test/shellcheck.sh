#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

TEST_DIR=$(readlink -e "$(dirname "${0}")")
SCRIPT_DIR="$(readlink -e "${TEST_DIR}"/..)"

(
	cd "${SCRIPT_DIR}"
	# shellcheck disable=SC2046
	shellcheck $(find . -name '*.sh')
)

echo '$$ shellcheck passed $$'
exit 0
