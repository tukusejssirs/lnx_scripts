# This script checks if there is something to commit; if yes, commit the changes with commit message that is supplied as argument. It is same as `gup.sh`, except for the fact that it does not stage any files (they must be staged before running this function)

# author:  Tukusej's Sirs
# version: 1.0
# date:    20 Mar 2019

# TODO
# - when no msg is input as arg and ans is no, it won't ask me to input msg

#!/bin/bash
function gups(){
	# Check if there are any changes in local git repo since last commit
	# src: https://stackoverflow.com/a/5143914/3408342
	if [[ ! $(git diff-index --quiet HEAD --) ]]; then
		# Local repo changed
		if [[ -n $1 ]]; then
			git commit -m "$1"
			git push
		else
			echo "Do you really want to commit the changes without providing a message?"
			echo "[y]es, [n]o, [a]bort"
			read ans
			case ans in
				y|Y|yes|Yes|YES)
					git commit --allow-empty-message -m ""
					git push
					;;
				n|N|no|No|NO)
					# TODO: this part does not work
					echo "Provide a commit message please:"
					read cm
					git commit -m "$cm"
					;;
				a|A|abort|Abort|ABORT)
					exit 1
					;;
			esac
		fi
	else
		# Local repo did not changed
		echo "There were have been no changes made in the repo."
	fi
}