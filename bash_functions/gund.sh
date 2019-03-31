# This script undoes the last N commit (by default, last 1 commit)

# author:  Tukusej's Sirs
# version: 1.0
# date:    31 Mar 2019

function gund(){
	if [ "$1" -gt 1 ]; then
		git reset --soft HEAD~$1
	else
		git reset --soft HEAD~1
	fi
}