function fzf-better-alt-c --description "fzf-better-alt-c"
	set pattern_file ".ignore"
	
	set find_prefix "find -L . -mount -mindepth 1 \\( "
	set find_suffix " -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune -o -type d -print 2> /dev/null | fzf"
	
	set mypath ""
	set exclude ""
	if test -e  "$pattern_file" 
		cat "$pattern_file" | while read -l str
			echo "-path '*{$str}' -o " |string join -q exclude
			set exclude "$exclude -path '*{$str}*' -o "
		end
	end

	set mypath (eval {$find_prefix}{$exclude}{$find_suffix})

	if test $status = 0
		cd "$mypath"
		commandline -t ""
		commandline -it -- $prefix
	end
	commandline -f repaint
end
