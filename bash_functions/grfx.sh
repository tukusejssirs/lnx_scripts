# This function removes `origin` remote and re-adds it. Probably only in git v2.19.1, sometimes it happens it cannot fetch new branches (and probably anything). Note that it presumes that the main branch is called `master` and that the same name is used in the remote repo

# author:  Tukusej's Sirs
# date:    20 March 2019
# version: 1.1

function grfx(){
	local origin=$(git remote -v | grep origin.*fetch | awk '{print $2}')
	local branch_current=$(git rev-parse --abbrev-ref HEAD)
	local branch_main="master"

	# Remove and re-add the `origin` remote
	git remote rm origin
	git remote add origin "$origin"

	# Check out to `master` if I was not on `master` already
	if [[ "$branch_current" != "$branch_main" ]]; then
		git checkout $branch_main
	fi

	# Set upstream branch
	git branch --set-upstream-to=origin/$branch_main $branch_main

	# Fetch from remote
	git fetch

	# Check out back to the previous branch if I was not on `master`
	if [[ "$branch_current" != "$branch_main" ]]; then
		git checkout $branch_current
	fi
}