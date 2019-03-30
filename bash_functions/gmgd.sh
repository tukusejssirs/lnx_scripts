# This function merges branch $1 and then deletes branch $1

# author:  Tukusej's Sirs
# date:    30 March 2019
# version: 1.0
# $1       existing branch name

function gmgd(){
	git merge $1 && git branch --delete $1
}