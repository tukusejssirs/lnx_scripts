# This function creates a new branch, checks out to it and sets upstream of it to origin

# author:  Tukusej's Sirs
# date:    18 March 2019
# version: 1.0

# $1       new branch name

function gcb(){
	git checkout -b $1
	git push --set-upstream origin $1
}