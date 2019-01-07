#!/bin/bash
function src(){
	f=$1
	if [ -f $f ]; then  # If file exists and is a regular file, source it
		source $f
	elif [ -d $f ]; then # If directory, source the files in it
		for n in `ls $f`; do
			source $f/$n
		done
	elif [ -L $f ]; then
		path=$(file $f -b | sed 's/^symbolic link to //' -)
		if [[ -f $path ]]; then
			source $path
		elif [[ -d $path ]]; then
			for n in `ls $path`; do
				source $path/$n
			done
		fi
	fi
}
