# Gnome 3 can be customised from the command line via the gsettings command
# This script should help you to find what you're looking for by
# listing the ranges for all keys for each schema

# src: https://askubuntu.com/a/155321

#!/bin/bash
function gls(){
	for schema in $(gsettings list-schemas | sort)
	do
		for key in $(gsettings list-keys $schema | sort)
		do
			value="$(gsettings range $schema $key | tr "\n" " ")"
			echo "$schema :: $key :: $value"
		done
	done
}