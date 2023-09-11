#!/bin/bash

if [[ ! -d "fb0" ]] ; then
	mkdir "fb0"
	echo "{
	\"name\": \"your username\",
	\"ctx\": \"context\",
	\"img\": \"https://domain-name.domain/my_image.format\" 
}
" > "fb0/mymessage.json"
fi

export cf="$(find fb0 -type f -name *.json | wc -l)"

if [[ "${cf}" = "1" ]] && [[ ! -f "fb0/mymessage.json" ]] ; then
	export fn="$(find fb0 -type f -name *.json -exec basename \{} \;)"
	case "${fn}" in
		*\ *)
			echo "The file couldn't contain white spaces: \"${fn}\".."
			exit 1
		;;
		*)	
			{
				export name="$(jq -r .name "fb0/${fn}")"
				export context="$(jq -r .ctx "fb0/${fn}")"
				export img="$(jq -r .img fb0/${fn})"
			} 2> /dev/null
			if [[ -n "${name}" && "${name}" != "null" ]] && [[ -n "${context}" && "${context}" != "null" ]] ; then
				if [[ "${img}" = "null" ]] ;  then
					export img="https://images-ext-2.discordapp.net/external/Miy2JIJJEC28aM2l69PeWO04Dvy6yY__EX6CKj6Tk0o/%3Fsize%3D4096/https/cdn.discordapp.com/icons/527560284928213021/be028bc84321c9d9a57e85ddc5b5bce3.png"
				fi
				echo -e "name: ${name}\nctx: ${context}\nimg: true"
				exit 0
			else
				echo "\$name and \$ctx parameters is required, and the values can not be null."
				exit 1
			fi
		;;
	esac
else
	echo "You can create 1 \"json\" file in \"fb0\" per pull request and the file name can not be \"mymessage.json\"."
	exit 1
fi