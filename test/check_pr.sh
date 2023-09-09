#!/bin/bash

export fjson="$(find _data -type f -name *.json | wc -l)"

if [[ "${#fjson[@]}" = "1" ]] ; then
	:
else
	echo "You can create 1 json file in \"_data\" without per pull request."
	exit 1
fi
