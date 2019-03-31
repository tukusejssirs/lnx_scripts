# This function removes all branches (local or remote) that are already merged in the main branch (i.e. they can be found in `git log` of master)

# Name: Git Branch eXtermination

# author:  Tukusej's Sirs
# date:    31 March 2019
# version: 1.0

function gbx(){
	local main="master"
	# List all branches (local and remote) without "remote/" and do not list HEAD and $main branch
	local branches=$(git branch -a | sed 's/^[ \t*]*//g;s/^remotes\///g' - | grep -v "HEAD\|$main")

	# Delete all branches (remote or local) that are found in `git log $main" (i.e. they are merged into $main)
	for b in $branches; do
		local test=$(git log --pretty=format:"%h %d" $main | grep -Po "[( ]\K$b(?=[),])")
		if [ "$test" = "$b" ]; then
			case "$b" in
				*/*)
					remote=$(echo "$b" | grep -Po "^.*(?=/.*$)")
					rb=$(echo "$b" | grep -Po "^.*/\K.*$")
					git push $remote --delete $rb
				;;
				*)
					git branch --delete $b
				;;
			esac
		fi
	done
}