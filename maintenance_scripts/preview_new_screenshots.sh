#!/usr/bin/env bash
git status | grep modified | grep screenshots | awk '{print $2}' | xargs sxiv
