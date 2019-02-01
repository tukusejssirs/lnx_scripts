# This functions create a directory and then changes the current working director to it.

# author:  Tukusej's Sirs
# date:    26 Jan 2019
# version: 1.0

function mkcd(){
	mkdir $1
	cd $1
}