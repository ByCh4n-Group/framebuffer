#!/bin/bash

set -e

# Pre-conf for discord.sh
export dc_sv="Penguen Tux"
export default_img="https://images-ext-2.discordapp.net/external/Miy2JIJJEC28aM2l69PeWO04Dvy6yY__EX6CKj6Tk0o/%3Fsize%3D4096/https/cdn.discordapp.com/icons/527560284928213021/be028bc84321c9d9a57e85ddc5b5bce3.png"
export avatar="https://arduinointro.com/images/lcd-hello-world-900.jpg"
export author_img="https://cdn-icons-png.flaticon.com/512/25/25231.png"

case "${1,,}" in
	"push")
		if [[ -f "test/push.sh" ]] ; then
			source "test/push.sh"
		else
			echo "push.sh not found!"
			exit 1
		fi
	;;
	"check_pr")
		if [[ -f "test/check_pr.sh" ]] ; then
			source "test/check_pr.sh"
		else
			echo "check_pr not found!"
			exit 1
		fi
	;;
	*)
		echo "command list:
- push: Move under the \"_data\" and send it to Discord the message file. 
- check_pr: Pre-check if available to push the pr. 
"
	;;
esac
