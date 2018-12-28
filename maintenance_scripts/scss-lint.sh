#!/usr/bin/env bash
set -ueo pipefail


scss_lint_pattern="$HOME/.gem/ruby/*/bin/scss-lint"
scss_lint_candidates=( "$scss_lint_pattern" )
SCSS_LINT="${scss_lint_candidates[0]}"


if [[ -d ./gtk320lint ]] ; then
	rm -fr ./gtk320lint/
fi
cp -r src/gtk-3.20/ ./gtk320lint

_exit() {
	rm -fr ./gtk320lint/
}
trap _exit EXIT SIGHUP SIGINT SIGTERM INT


sed -ie 's/%[A-Z0-9_]\+%/123456/g' ./gtk320lint/scss/_global.scss
"${SCSS_LINT}" ./gtk320lint/
