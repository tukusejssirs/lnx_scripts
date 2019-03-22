# This function creates a branch that tracks a remote branch of the same name, or only what is needed to have all existing remote branches tracked

# author:  Tukusej's Sirs
# date:    21 March 2019
# version: 1.0

#function gbta(){

# TODO
# - warn about missing HEAD ref
# - exclude HEAD from remotes
# - make it a function
# - save current branch a check back to it

remote_branches=$(git branch -r | sed 's/^[ ]*//g' -)

# HEAD test
if [[ $(echo "$remote_branches" | grep -o HEAD) == "HEAD" ]]; then
	# Remove HEAD from the variable
	remote_branches=$(echo "$remote_branches" | sed '/HEAD/d' -)
else
	# Warn about missing HEAD
	echo -e "${lyellow}WARNING: No HEAD found.${fdefault}"
fi

# If remote branch does not exist locally, create it
# If remote branch exists locally, but is not tracked, make it tracked
for r in $remote_branches; do
	echo
	branch_name=$(echo $r | grep -o "[^/]*$")
	branch_test=$(git branch --list $branch_name | sed 's/^[ *]*//g' -)
	is_tracking=$(git rev-parse --abbrev-ref $branch_name@{upstream} &>/dev/null | echo $?)
	echo branch: "$branch_name (test: $branch_test, track: $is_tracking)"
#	if [[ $branch_name != $branch_test || $is_tracking != 0 ]]; then
#		if [[ $is_tracking != 0 ]]; then
		if [[ $branch_name != $branch_test ]]; then
			git checkout -b $branch_name
			echo branch created
		else
			#git checkout $branch_name
			echo branch no checkout
		fi
		#git checkout --track $r
		git branch -u $r $branch_name
		echo "$branch_name is set to track $r"
	#fi
done
#}