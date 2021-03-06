# This function commits all changes from current directory to $branch (locally and remotely), check outs to master, merges and commits all changes from $branch, deletes the $branch (locally and remotely) and finally pushes all the changes to the remotes.

# Note that this function sources `gup` and `gbd` functions, which presumes that you have cloned the repo in `$HOME/git/lnx_scripts` folder.

# Also, currently the function presumes that the main branch is called `master`.

# The function's name comes from the following words: Git Update Merge Push

# author:  Tukusej's Sirs
# date:    11 April 2019
# version: 1.1
# $1       commit message

function gump(){
	# Variables
	branch=$(git rev-parse --abbrev-ref HEAD)
	main="master"
	msg="$1"
	script_dir=$(realpath $(dirname $0))
	lnx_scripts=$(dirname $(dirname $(realpath $PWD/$0)))

	# Source `gup` and `gbd` functions
	source $lnx_scripts_dir/bash_functions/gup.sh
	source $lnx_scripts_dir/bash_functions/gbd.sh

	gup "$msg" && git checkout $main && git merge $branch && gbd $branch && git push
}