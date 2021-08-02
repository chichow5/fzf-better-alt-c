pattern_file=".ignore"

find_prefix="find -L . -mount -mindepth 1 \\( "
find_suffix=" -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune -o -type d -print 2> /dev/null | fzf"

function better_alt_c(){

	# get exclude files from ./.ignore
	exclude=""
	while read str; do
		exclude="$exclude -path '*$str*' -o "
	done <$pattern_file
	
	# echo "$find_prefix$exclude$find_suffix"

	mypath=$(eval ${find_prefix}${exclude}${find_suffix})

	cd $mypath
	zle reset-prompt
}

zle -N better_alt_c
bindkey '\et' better_alt_c
