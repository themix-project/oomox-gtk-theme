#!/usr/bin/env bash
set -ueo pipefail

if [[ -d ./gtk320lint ]] ; then
	rm -fr ./gtk320lint/
fi
cp -r src/gtk-3.20/ ./gtk320lint

_exit() {
	rm -fr ./gtk320lint/
}
trap _exit EXIT SIGHUP SIGINT SIGTERM INT

sed -ie 's/%[A-Z0-9_]\+%/123456/g' ./gtk320lint/scss/_global.scss
~/.gem/ruby/2.4.0/bin/scss-lint ./gtk320lint/
