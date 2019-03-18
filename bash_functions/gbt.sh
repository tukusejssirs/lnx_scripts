# This function creates a new branch, checks out it and starts tracking the remote branch of the same same

# author:  Tukusej's Sirs
# date:    18 March 2019
# version: 1.0
# $1       existing branch name ideally prefixed with remote’s name and a slash

function gbt(){
	if [ -z "${1##*/*}" ]; then
		branch="$1"
	else
		branch="origin/$1"
	fi

	git checkout --track $branch
}