#!/usr/bin/env bash
git log \
	--pretty=tformat:"%Cred%D%Creset %ad %Cgreen%h %Cblue%an %Creset%s" \
	--date='format:%Y-%m-%d' \
	--color=always \
	$(git tag | grep -v gtk | sort -V | tail -n1)~1.. \
	$@
