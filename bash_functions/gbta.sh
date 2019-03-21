# This function creates a branch that tracks a remote branch of the same name, or only what is needed to have all existing remote branches tracked

# author:  Tukusej's Sirs
# date:    21 March 2019
# version: 1.0

#function gbta(){

# TODO
# - warn about missing HEAD ref
# - exclude HEAD from remotes

remote_branches=$(git branch -r)

# HEAD test
if [[ $(echo $remote_branches | grep -o HEAD) == "HEAD" ]]; then
	# Remove HEAD from the variable
	remote_branches=$(echo $remote | sed '/HEAD/d' -)
else
	# Warn about missing HEAD
	echo -e "${lyellow}WARNING: No HEAD found.${fdefault}"
fi

# If remote branch does not exist locally, create it
# If remote branch exists locally, but is not tracked, make it tracked
for r in $remote_branches; do
	branch_name=$(echo $r | grep -o "[^/]*$")
	branch_test=$(git branch --list $branch_name)
	is_tracking=$(git rev-parse --abbrev-ref $branch_name@{upstream} &>/dev/null | echo $?)
	if [[ $branch_name != $branch_test || $is_tracking != 0 ]]; then
		if [[ $is_tracking != 0 ]]; then
			git checkout $branch_name
		else
			git checkout -b $branch_name
		fi
		git checkout --track $r
		echo "$branch_name is set to track $r"
	fi
done
#}