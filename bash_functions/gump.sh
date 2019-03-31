# This function commits all changes from current directory to $branch (locally and remotely), check outs to master, merges and commits all changes from $branch, deletes the $branch (locally and remotely) and finally pushes all the changes to the remotes.

# Note that this function sources `gup` function, which presumes that you have cloned the repo in `$HOME/git/lnx_scripts` folder.

# Also, currently the function presumes that the main branch is called `master`.

# The function's name comes from the following words: Git Update Merge Push

# author:  Tukusej's Sirs
# date:    31 March 2019
# version: 1.0
# $1       existing branch name

function gump(){
	# Variables
	branch=$(git rev-parse --abbrev-ref HEAD)
	main="master"
	msg=$1
	script_dir=$(realpath $(dirname $0))

	if [ $(echo $script_dir | grep -o lnx_scripts) ]; then
		lnx_scripts_dir=$(echo $script_dir | sed 's/\(lnx_scripts\)\/.*$/\1/' -)
	else
		lnx_scripts_dir="$HOME/git/lnx_scripts"
	fi

	# Source `gup` function
	source $lnx_scripts_dir/bash_functions/gup.sh

	gup $msg && git checkout $main && git merge $branch && git branch --delete $branch && git push
}