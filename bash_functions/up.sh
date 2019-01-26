# This script is used to move up the directories using `up n`, where `n` is an integer, how many dirs should be moved up

# author: Tukusej's Sirs (based upon what I found on the Internet)
# created: 25 Feb 2018 (v1.0); 1 Jan 2019 (v1.1); 26 Jan 2019 (v1.2)
# dependencies: coreutils
# version: 1.2

function up(){
	if [[ $1 = "" ]]; then d=1; else d=$1; fi
	if [[ $d -lt 1 ]]; then echo "Argument must be a positive integer."; fi

	for n in $(seq 1 $d); do dots+="../"; done
	cd $dots
}