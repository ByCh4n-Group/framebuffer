#!/bin/bash

if [[ "$(find fb0 -type f -name *.json | wc -l)" = "1" ]] && [[ ! -f "fb0/mymessage.json" ]] ; then
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
				if [[ "${img}" = "null" || -z "${img}" ]] ;  then
					export img="${default_img}"
				fi
                if [[ ! -d "_data" ]] ; then
                    mkdir "_data"
                fi
				mv "fb0/${fn}" "_data/${fn}"
                if [[ -f "fb0/"* ]] ; then
                    rm "fb0/"*
                fi
                echo "{
	\"name\": \"your username\",
	\"ctx\": \"context\",
	\"img\": \"https://domain-name.domain/my_image.format\" 
}
" > "fb0/mymessage.json"
                bash "discord.sh/discord.sh"    --webhook-url "${discord}" \
                                                --username "FrameBuffer" \
                                                --avatar "${avatar}" \
                                                --title "${name}" \
                                                --description "${context}" \
                                                --color "0xFFFFFF" \
                                                --url "https://bych4n-group.github.io/framebuffer" \
                                                --author "framebuffer" \
                                                --author-url "https://github.com/ByCh4n-Group/framebuffer" \
                                                --author-icon "${author_img}" \
                                                --footer "${dc_sv}" \
                                                --thumbnail "${img}" \
                                                --footer-icon "${default_img}" \
                                                --timestamp
				exit 0
			else
				echo "\$name and \$ctx parameters is required, and the values can not be null."
				exit 1
			fi

        ;;
    esac
else
	echo "You can create 1 \"json\" file in \"fb0\" per commit and the file name can not be \"mymessage.json\"."
    exit 1
fi