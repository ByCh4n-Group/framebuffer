#!/bin/bash

export fjson=($(git diff --name-only "${eventb}" "${events}" | grep '^_data/.*\.json$'))

if [[ "${#fjson[@]}" = "1" ]] ; then
	:
else
	echo "You can create 1 json file in \"_data\" without per pull request."
	exit 1
fi
