#!/bin/bash
function src(){
	f=$1
	if [ -f $f ]; then  # If file exists and is a regular file, source it
		# If symlink, source the source file
		test=$(file $f -b)
		if [[ $(echo $f | grep "^symbolic link" -o) == "symbolic link" ]]; then
			path=$(echo $test | sed 's/^symbolic link to //' -)
			source $path
		else
			source $f
		fi
	elif [ -d $f ]; then # If directory, source the files in it
		# If symlink, source the files in the source directory
		test=$(file $f -b)
		if [[ $(echo $f | grep "^symbolic link" -o) == "symbolic link" ]]; then
			path=$(echo $test | sed 's/^symbolic link to //' -)
			for n in `ls $path`; do
				source $path/$n
			done
		else
			for n in `ls $f`; do
				source $f/$n
			done
		fi
	fi
}