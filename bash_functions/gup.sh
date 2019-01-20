# This script checks if there is something to commit; if yes, commit the changes with commit message that is supplied as argument.

# author:  Tukusej's Sirs
# version: 1.1
# date:    20 Jan 2019

# TODO
# - when no msg is input as arg and ans is no, it won't ask me to input msg

#!/bin/bash
function gup(){
	# Check if there are any changes in local git repo since last commit
	# src: https://stackoverflow.com/a/5143914/3408342
	if [[ ! $(git diff-index --quiet HEAD --) ]]; then
		# Local repo changed
		if [[ -n $1 ]]; then
			git add --all
			git commit -am "$1"
			git push
		else
			echo "Do you really want to commit the changes without providing a message?"
			echo "[y]es, [n]o, [a]bort"
			read ans
			case ans in
				y|Y|yes|Yes|YES)
					git add --all
					git commit --allow-empty-message -am ""
					git push
					;;
				n|N|no|No|NO)
					# TODO: this part does not work
					echo "Provide a commit message please:"
					read cm
					git add --all
					git commit -am "$cm"
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