pattern_file=".ignore"

find_prefix="find -L . -mount -mindepth 1 \\( "
find_suffix=" -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune -o -type d -print 2> /dev/null | fzf"

function better_alt_c(){
	# get exclude files from ./.ignore
	local mypath exclude=""
	if [[ -f "$pattern_file" ]];then
		while read str; do
			exclude="$exclude -path '*$str*' -o "
		done <$pattern_file
	fi

	
	mypath=$(eval ${find_prefix}${exclude}${find_suffix})

	if [[ $? == 0 ]];then
		$(printf 'cd %q' "$mypath")
	fi

	if [[ $SHELL == "/bin/zsh" ]];then
		zle reset-prompt
	fi
}

if [[ $SHELL ==  "/bin/zsh" ]];then
	zle -N better_alt_c
	bindkey '\et' better_alt_c
elif [[ $SHELL == "/bin/bash" ]];then
	bind -x '"\et"':better_alt_c
fi
