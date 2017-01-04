#!/usr/bin/env bash

function output_help {
    echo "usage: git-revert-file <sha1> <file>"
}

sha1=$1
file=$2

if [[ $file ]]; then
git diff $sha1..$sha1^ -- $file | patch -p1
else
output_help
fi
