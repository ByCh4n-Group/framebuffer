#!/bin/bash

case "${1,,}" in
	"push")
		bash "discord.sh/discord.sh" --webhook-url "${DISCORD}" --text "Test"
	;;
esac
