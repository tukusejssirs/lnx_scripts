# This script is used to move up the directories using `up n`, where `n` is an integer, how many dirs should be moved up

# author: Tukusej's Sirs (based upon what I found on the Internet)
# created: 25 Feb 2018
# dependencies: cd do done for seq
# version: 1.0

function up(){
	for n in $(seq 1 $1); do dots+="../"; done
	cd $dots
	n=""
	dots=""
}