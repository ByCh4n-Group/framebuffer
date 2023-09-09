#!/bin/bash

case "${1,,}" in
	"push")
		bash "discord.sh/discord.sh" --webhooh-url "${DISCORD}" --text "Test"
	;;
esac
