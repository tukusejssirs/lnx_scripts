# This function removes the specified branch locally and remotely

# author:  Tukusej's Sirs
# date:    18 March 2019
# version: 1.0

# $1       existing branch name

function gbd(){
	git branch --delete $1
	git push origin --delete $1
}