#!/bin/bash

set -e

case "${1,,}" in
	"push")
		bash "discord.sh/discord.sh" --webhook-url "${discord}" --text "Test"
	;;
	"check_pr")
		if [[ -f "test/check_pr.sh" ]] ; then
			source "test/check_pr.sh"
		else
			exit 1
		fi
	;;
esac
